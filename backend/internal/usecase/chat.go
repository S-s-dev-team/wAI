package usecase

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
)

type ChatUsecase struct {
	chatRepository domain.ChatRepository
}

func NewChatUsecase(chatRepository domain.ChatRepository) *ChatUsecase {
	return &ChatUsecase{chatRepository: chatRepository}
}

type CreateChatInput struct {
	UserID uuid.UUID
	Title  string
}

type ChatOutput struct {
	Chat *domain.Chat
}

type ChatListOutput struct {
	Chats []*domain.Chat
}

func (u *ChatUsecase) Create(ctx context.Context, input CreateChatInput) (*ChatOutput, error) {
	chat, err := u.chatRepository.Create(ctx, &domain.Chat{
		UserID: input.UserID,
		Title:  input.Title,
	})
	if err != nil {
		return nil, err
	}
	return &ChatOutput{Chat: chat}, nil
}

func (u *ChatUsecase) GetByID(ctx context.Context, id uuid.UUID) (*ChatOutput, error) {
	chat, err := u.chatRepository.GetByID(ctx, id)
	if err != nil {
		return nil, err
	}
	return &ChatOutput{Chat: chat}, nil
}

func (u *ChatUsecase) ListByUserID(ctx context.Context, userID uuid.UUID) (*ChatListOutput, error) {
	chats, err := u.chatRepository.ListByUserID(ctx, userID)
	if err != nil {
		return nil, err
	}
	return &ChatListOutput{Chats: chats}, nil
}
