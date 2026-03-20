package usecase

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"strings"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
)

type InsightUsecase struct {
	insightRepo         domain.InsightRepository
	insightCategoryRepo domain.InsightCategoryRepository
	messageRepo         domain.MessageRepository
	aiRepo              domain.AIRepository
}

func NewInsightUsecase(
	insightRepo domain.InsightRepository,
	insightCategoryRepo domain.InsightCategoryRepository,
	messageRepo domain.MessageRepository,
	aiRepo domain.AIRepository,
) *InsightUsecase {
	return &InsightUsecase{
		insightRepo:         insightRepo,
		insightCategoryRepo: insightCategoryRepo,
		messageRepo:         messageRepo,
		aiRepo:              aiRepo,
	}
}

type AnalyzeOutput struct {
	Insights   []*domain.Insight
	Categories map[uuid.UUID]*domain.InsightCategory
}

type DashboardCategory struct {
	CategoryKey string
	DisplayName string
	Insights    []*domain.Insight
}

type DashboardOutput struct {
	Categories     []DashboardCategory
	RecentInsights []*domain.Insight
	TotalCount     int
	AllCategories  map[uuid.UUID]*domain.InsightCategory
}

type aiInsightResponse struct {
	Insights []struct {
		CategoryKey string `json:"category_key"`
		Content     string `json:"content"`
	} `json:"insights"`
}

func (u *InsightUsecase) Analyze(ctx context.Context, userID uuid.UUID, chatID uuid.UUID) (*AnalyzeOutput, error) {
	// 1. 過去メッセージ履歴を取得
	messages, err := u.messageRepo.ListByChatID(ctx, chatID, 20, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to get messages: %w", err)
	}

	if len(messages) == 0 {
		return &AnalyzeOutput{
			Insights:   []*domain.Insight{},
			Categories: map[uuid.UUID]*domain.InsightCategory{},
		}, nil
	}

	// 2. 全カテゴリを取得
	categories, err := u.insightCategoryRepo.List(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to get categories: %w", err)
	}

	categoryMap := make(map[string]*domain.InsightCategory)
	categoryByID := make(map[uuid.UUID]*domain.InsightCategory)
	for _, c := range categories {
		categoryMap[c.CategoryKey] = c
		categoryByID[c.ID] = c
	}

	// 3. 会話ログを構築
	var conversationLog strings.Builder
	for _, m := range messages {
		if m.SenderType == "user" {
			conversationLog.WriteString("【就活生】" + m.Content + "\n")
		} else {
			conversationLog.WriteString("【先輩】" + m.Content + "\n")
		}
	}

	// 4. Geminiに分析リクエスト
	systemPrompt := `あなたは就活生の自己分析を支援するアナリストです。
以下のチャット会話を分析し、就活生の特徴をJSON形式で抽出してください。

カテゴリ:
- values（価値観）: 仕事や人生において大切にしていること
- strengths（強み）: 自分の得意なこと・優れている点
- interests（興味・関心）: 興味を持っている分野やテーマ

出力形式（JSON）:
{"insights": [{"category_key": "values", "content": "..."}, ...]}

注意:
- 各カテゴリ0〜3件程度
- 会話から読み取れるものだけ。推測は最小限に
- content は簡潔な日本語で（1〜2文）
- JSON以外のテキストは出力しないでください`

	aiResp, err := u.aiRepo.SendMessage(ctx, &domain.AIRequest{
		SystemPrompt: systemPrompt,
		History:      nil,
		UserMessage:  "以下の会話を分析してください:\n\n" + conversationLog.String(),
	})
	if err != nil {
		return nil, fmt.Errorf("failed to analyze with AI: %w", err)
	}

	// 5. AIの応答をJSONパース
	content := aiResp.Content
	log.Printf("[Insight] raw AI response: %s", content)

	// マークダウンコードブロックを除去
	content = strings.TrimSpace(content)
	if strings.HasPrefix(content, "```") {
		lines := strings.Split(content, "\n")
		if len(lines) > 2 {
			lines = lines[1 : len(lines)-1]
			content = strings.Join(lines, "\n")
		}
	}
	content = strings.TrimSpace(content)

	var parsed aiInsightResponse
	if err := json.Unmarshal([]byte(content), &parsed); err != nil {
		log.Printf("[Insight] failed to parse AI response: %v, content: %s", err, content)
		return nil, fmt.Errorf("failed to parse AI response: %w", err)
	}

	log.Printf("[Insight] parsed %d insights from AI", len(parsed.Insights))

	// 6. 各インサイトを保存
	var savedInsights []*domain.Insight
	for _, item := range parsed.Insights {
		cat, ok := categoryMap[item.CategoryKey]
		if !ok {
			log.Printf("[Insight] unknown category_key: %s, skipping", item.CategoryKey)
			continue
		}

		chatIDCopy := chatID
		insight, err := u.insightRepo.Create(ctx, &domain.Insight{
			UserID:     userID,
			ChatID:     &chatIDCopy,
			CategoryID: cat.ID,
			Content:    item.Content,
		})
		if err != nil {
			return nil, fmt.Errorf("failed to save insight: %w", err)
		}
		savedInsights = append(savedInsights, insight)
	}

	return &AnalyzeOutput{
		Insights:   savedInsights,
		Categories: categoryByID,
	}, nil
}

func (u *InsightUsecase) GetDashboard(ctx context.Context, userID uuid.UUID) (*DashboardOutput, error) {
	// 1. ユーザーの全インサイトを取得
	insights, err := u.insightRepo.ListByUserID(ctx, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get insights: %w", err)
	}

	// 2. 全カテゴリを取得
	categories, err := u.insightCategoryRepo.List(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to get categories: %w", err)
	}

	categoryByID := make(map[uuid.UUID]*domain.InsightCategory)
	for _, c := range categories {
		categoryByID[c.ID] = c
	}

	// 3. カテゴリ別にグループ化
	groupedMap := make(map[string][]*domain.Insight)
	for _, insight := range insights {
		cat, ok := categoryByID[insight.CategoryID]
		if !ok {
			continue
		}
		groupedMap[cat.CategoryKey] = append(groupedMap[cat.CategoryKey], insight)
	}

	var dashCategories []DashboardCategory
	for _, cat := range categories {
		dashCategories = append(dashCategories, DashboardCategory{
			CategoryKey: cat.CategoryKey,
			DisplayName: cat.DisplayName,
			Insights:    groupedMap[cat.CategoryKey],
		})
	}

	// 4. 最新の気づき（全カテゴリから5件）
	recentCount := 5
	if len(insights) < recentCount {
		recentCount = len(insights)
	}
	recentInsights := insights[:recentCount]

	return &DashboardOutput{
		Categories:     dashCategories,
		RecentInsights: recentInsights,
		TotalCount:     len(insights),
		AllCategories:  categoryByID,
	}, nil
}
