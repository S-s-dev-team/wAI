package repository

import (
	"context"
	"fmt"
	"log"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/generative-ai-go/genai"
)

type Gemini struct {
	client *genai.Client
}

func NewGemini(client *genai.Client) domain.AIRepository {
	return &Gemini{client: client}
}

func (r *Gemini) SendMessage(ctx context.Context, req *domain.AIRequest) (*domain.AIResponse, error) {
	model := r.client.GenerativeModel("gemini-2.5-flash")
	model.SystemInstruction = &genai.Content{
		Parts: []genai.Part{genai.Text(req.SystemPrompt)},
	}

	chat := model.StartChat()
	for _, m := range req.History {
		chat.History = append(chat.History, &genai.Content{
			Parts: []genai.Part{genai.Text(m.Content)},
			Role:  m.Role,
		})
	}

	// ログ: リクエスト内容
	log.Printf("[Gemini Request] system_prompt=%q user_message=%q history_count=%d",
		req.SystemPrompt, req.UserMessage, len(req.History))

	resp, err := chat.SendMessage(ctx, genai.Text(req.UserMessage))
	if err != nil {
		log.Printf("[Gemini Error] error=%v", err)
		return nil, fmt.Errorf("failed to call gemini: %w", err)
	}

	// ログ: レスポンスメタ情報
	log.Printf("[Gemini Response] candidates=%d", len(resp.Candidates))
	if resp.UsageMetadata != nil {
		log.Printf("[Gemini Usage] prompt_tokens=%d candidates_tokens=%d total_tokens=%d",
			resp.UsageMetadata.PromptTokenCount, resp.UsageMetadata.CandidatesTokenCount, resp.UsageMetadata.TotalTokenCount)
	}

	// テキスト抽出
	var replyContent string
	for i, candidate := range resp.Candidates {
		if candidate.Content == nil {
			continue
		}
		for _, part := range candidate.Content.Parts {
			if text, ok := part.(genai.Text); ok {
				replyContent = string(text)
				log.Printf("[Gemini Reply] candidate=%d content=%q", i, replyContent)
			}
		}
	}

	var aiResp domain.AIResponse
	aiResp.Content = replyContent
	if resp.UsageMetadata != nil {
		aiResp.PromptTokens = resp.UsageMetadata.PromptTokenCount
		aiResp.ReplyTokens = resp.UsageMetadata.CandidatesTokenCount
		aiResp.TotalTokens = resp.UsageMetadata.TotalTokenCount
	}

	return &aiResp, nil
}
