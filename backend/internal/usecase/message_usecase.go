package usecase

import (
	"context"
	"fmt"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
)

type MessageUsecase struct {
	messageRepository domain.MessageRepository
	personaRepository domain.PersonaRepository
	aiRepository      domain.AIRepository
}

func NewMessageUsecase(
	messageRepository domain.MessageRepository,
	personaRepository domain.PersonaRepository,
	aiRepository domain.AIRepository,
) *MessageUsecase {
	return &MessageUsecase{
		messageRepository: messageRepository,
		personaRepository: personaRepository,
		aiRepository:      aiRepository,
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

func (u *MessageUsecase) Send(ctx context.Context, input SendMessageInput) (*SendMessageOutput, error) {
	userMsg, err := u.messageRepository.Create(ctx, &domain.Message{
		ChatID:     input.ChatID,
		SenderType: "user",
		Content:    input.Content,
	})
	if err != nil {
		return nil, err
	}

	persona, err := u.personaRepository.GetByChatID(ctx, input.ChatID)
	if err != nil {
		return nil, fmt.Errorf("failed to get persona: %w", err)
	}

	systemPrompt := buildSystemPrompt(persona)

	pastMessages, err := u.messageRepository.ListByChatID(ctx, input.ChatID, 50, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to get past messages: %w", err)
	}

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

	aiResp, err := u.aiRepository.SendMessage(ctx, &domain.AIRequest{
		SystemPrompt: systemPrompt,
		History:      history,
		UserMessage:  input.Content,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to send ai message: %w", err)
	}

	replyMsg, err := u.messageRepository.Create(ctx, &domain.Message{
		ChatID:     input.ChatID,
		SenderType: "persona",
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

func (u *MessageUsecase) List(ctx context.Context, input ListMessagesInput) (*ListMessagesOutput, error) {
	limit := input.Limit
	if limit <= 0 {
		limit = 50
	}

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
	prompt := fmt.Sprintf(
		"あなたは「%s」という名前の先輩です。"+
			"年齢: %d歳、性別: %s、職業: %s、年収: %d万円。"+
			"この人物になりきって、後輩に対してアドバイスや会話をしてください。"+
			"フレンドリーで親しみやすい口調で話してください。",
		persona.Name, persona.Age, persona.Gender, persona.Occupation, persona.AnnualIncome,
	)
	if persona.SystemPrompt != "" {
		prompt += "\n追加の指示: " + persona.SystemPrompt
	}
	return prompt
}
