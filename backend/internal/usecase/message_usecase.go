package usecase

import (
	"context"
	"fmt"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
)

type MessageUsecase struct {
	messageRepository         domain.MessageRepository
	personaRepository         domain.PersonaRepository
	chatParticipantRepository domain.ChatParticipantRepository
	aiRepository              domain.AIRepository
}

func NewMessageUsecase(
	messageRepository domain.MessageRepository,
	personaRepository domain.PersonaRepository,
	chatParticipantRepository domain.ChatParticipantRepository,
	aiRepository domain.AIRepository,
) *MessageUsecase {
	return &MessageUsecase{
		messageRepository:         messageRepository,
		personaRepository:         personaRepository,
		chatParticipantRepository: chatParticipantRepository,
		aiRepository:              aiRepository,
	}
}

type SendMessageInput struct {
	ChatID  uuid.UUID
	Content string
}

type SendMessageOutput struct {
	UserMessage *domain.Message
	Replies     []*domain.Message
}

type ListMessagesInput struct {
	ChatID uuid.UUID
	Limit  int
	Before *uuid.UUID
}

type ListMessagesOutput struct {
	Messages []*domain.Message
	HasMore  bool
}

type CallPersonaInput struct {
	ChatID    uuid.UUID
	PresetKey string
}

func (u *MessageUsecase) Send(ctx context.Context, input SendMessageInput) (*SendMessageOutput, error) {
	// ユーザーメッセージを保存
	userMsg, err := u.messageRepository.Create(ctx, &domain.Message{
		ChatID:     input.ChatID,
		SenderType: "user",
		Content:    input.Content,
	})
	if err != nil {
		return nil, err
	}

	// Personaのシステムプロンプトを取得
	persona, err := u.personaRepository.GetByChatID(ctx, input.ChatID)
	if err != nil {
		return nil, fmt.Errorf("failed to get persona: %w", err)
	}

	// システムプロンプトを構築
	systemPrompt := buildSystemPrompt(persona)

	// 過去のメッセージを取得して会話履歴を構築
	pastMessages, err := u.messageRepository.ListByChatID(ctx, input.ChatID, 50, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to get past messages: %w", err)
	}

	// 会話履歴を構築（最新のユーザーメッセージは除く）
	var history []domain.ChatMessage
	for _, m := range pastMessages {
		if m.ID == userMsg.ID {
			continue
		}
		role := "user"
		if m.SenderType == "persona" {
			role = "model"
		}
		history = append(history, domain.ChatMessage{
			Role:    role,
			Content: m.Content,
		})
	}

	// AIにリクエスト送信
	aiResp, err := u.aiRepository.SendMessage(ctx, &domain.AIRequest{
		Model:        "gemini-3.1-pro-preview",
		SystemPrompt: systemPrompt,
		History:      history,
		UserMessage:  input.Content,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to send ai message: %w", err)
	}

	// AIの返答を保存
	replyMsg, err := u.messageRepository.Create(ctx, &domain.Message{
		ChatID:     input.ChatID,
		SenderType: "persona",
		PersonaID:  &persona.ID,
		Content:    aiResp.Content,
	})
	if err != nil {
		return nil, err
	}

	return &SendMessageOutput{
		UserMessage: userMsg,
		Replies:     []*domain.Message{replyMsg},
	}, nil
}

func (u *MessageUsecase) CallPersona(ctx context.Context, input CallPersonaInput) (*domain.Message, error) {
	// 1. プリセット先輩を取得
	persona, err := u.personaRepository.GetByPresetKey(ctx, input.PresetKey)
	if err != nil {
		return nil, fmt.Errorf("failed to get preset persona: %w", err)
	}

	// 2. chat_participants に追加（既にあればスキップ）
	participants, err := u.chatParticipantRepository.ListByChatID(ctx, input.ChatID)
	if err != nil {
		return nil, fmt.Errorf("failed to list participants: %w", err)
	}
	alreadyJoined := false
	for _, p := range participants {
		if p.PersonaID == persona.ID {
			alreadyJoined = true
			break
		}
	}
	if !alreadyJoined {
		_, err = u.chatParticipantRepository.Create(ctx, &domain.ChatParticipant{
			ChatID:    input.ChatID,
			PersonaID: persona.ID,
		})
		if err != nil {
			return nil, fmt.Errorf("failed to add participant: %w", err)
		}
	}

	// 3. 過去メッセージ履歴を取得
	pastMessages, err := u.messageRepository.ListByChatID(ctx, input.ChatID, 50, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to get past messages: %w", err)
	}

	// チャットの元の先輩の名前を取得
	originalPersona, _ := u.personaRepository.GetByChatID(ctx, input.ChatID)
	originalName := "別の先輩"
	if originalPersona != nil {
		originalName = originalPersona.Name
	}

	// 過去の会話を第三者視点のテキストとして構築
	var conversationLog string
	for _, m := range pastMessages {
		if m.SenderType == "user" {
			conversationLog += "【就活生】" + m.Content + "\n"
		} else {
			// 元の先輩の発言として記録
			senderName := originalName
			if m.PersonaID != nil && originalPersona != nil && *m.PersonaID != originalPersona.ID {
				// 別のプリセット先輩の発言
				p, err := u.personaRepository.GetByID(ctx, *m.PersonaID)
				if err == nil {
					senderName = p.Name
				}
			}
			conversationLog += "【" + senderName + "】" + m.Content + "\n"
		}
	}

	// 4. システムプロンプトに「別の先輩として途中参加」する指示を追加
	systemPrompt := persona.SystemPrompt + "\n\n" +
		"【重要な前提】\n" +
		"あなたは「" + persona.Name + "」です。\n" +
		"就活生が「" + originalName + "」と相談をしていたところに、別の視点を持つ先輩として途中から呼ばれました。\n" +
		"以下はこれまでの会話ログです。これはあなたの発言ではなく、就活生と「" + originalName + "」のやりとりです。\n" +
		"この会話内容を踏まえた上で、あなた独自の立場・視点から新たにアドバイスしてください。\n" +
		"「" + originalName + "」の意見に同調するのではなく、あなたならではの切り口で話してください。\n" +
		"自己紹介を簡潔にしてから本題に入ってください。\n\n" +
		"--- これまでの会話ログ ---\n" + conversationLog

	aiResp, err := u.aiRepository.SendMessage(ctx, &domain.AIRequest{
		Model:        "gemini-3.1-pro-preview",
		SystemPrompt: systemPrompt,
		History:      nil,
		UserMessage:  "会話を読んだ上で、あなたの立場からアドバイスをお願いします。",
	})
	if err != nil {
		return nil, fmt.Errorf("failed to send ai message: %w", err)
	}

	// 5. 応答を Message として保存（persona_id 付き）
	replyMsg, err := u.messageRepository.Create(ctx, &domain.Message{
		ChatID:     input.ChatID,
		SenderType: "persona",
		PersonaID:  &persona.ID,
		Content:    aiResp.Content,
	})
	if err != nil {
		return nil, err
	}

	return replyMsg, nil
}

func (u *MessageUsecase) List(ctx context.Context, input ListMessagesInput) (*ListMessagesOutput, error) {
	limit := input.Limit
	if limit <= 0 {
		limit = 50
	}

	// 1件多く取得してhasMoreを判定
	messages, err := u.messageRepository.ListByChatID(ctx, input.ChatID, limit+1, input.Before)
	if err != nil {
		return nil, err
	}

	hasMore := len(messages) > limit
	if hasMore {
		messages = messages[:limit]
	}

	return &ListMessagesOutput{
		Messages: messages,
		HasMore:  hasMore,
	}, nil
}

func buildSystemPrompt(persona *domain.Persona) string {
	age := 0
	if persona.Age != nil {
		age = *persona.Age
	}
	gender := ""
	if persona.Gender != nil {
		gender = *persona.Gender
	}
	occupation := ""
	if persona.Occupation != nil {
		occupation = *persona.Occupation
	}
	annualIncome := 0
	if persona.AnnualIncome != nil {
		annualIncome = *persona.AnnualIncome
	}

	prompt := fmt.Sprintf(
		"あなたは「%s」という名前の、就活を終えた社会人の先輩です。\n"+
			"年齢: %d歳、性別: %s、職業: %s、年収: %d万円。\n"+
			"%s\n"+
			"## 会話のルール\n"+
			"- 先輩として親しみやすく、でも敬語は崩しすぎない\n"+
			"- 一方的にアドバイスするだけでなく、後輩の考えを引き出す質問を必ず1つ含める\n"+
			"- 抽象的な正論ではなく、自分の実体験に基づいて話す（架空でOK）\n"+
			"- 短い相談には100字以内で、詳しい相談には200字程度で返す",
		persona.Name, age, gender, occupation, annualIncome, persona.SystemPrompt,
	)
	return prompt
}
