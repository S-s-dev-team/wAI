package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Chat struct {
	db *gorm.DB
}

func NewChat(db *gorm.DB) domain.ChatRepository {
	return &Chat{db: db}
}

func (r *Chat) Create(ctx context.Context, chat *domain.Chat) (*domain.Chat, error) {
	result := r.db.WithContext(ctx).Create(chat)
	if result.Error != nil {
		return nil, result.Error
	}
	return chat, nil
}

func (r *Chat) GetByID(ctx context.Context, id uuid.UUID) (*domain.Chat, error) {
	var chat domain.Chat
	result := r.db.WithContext(ctx).Where("id = ?", id).First(&chat)
	if result.Error != nil {
		return nil, result.Error
	}
	return &chat, nil
}

func (r *Chat) ListByUserID(ctx context.Context, userID uuid.UUID) ([]*domain.Chat, error) {
	var chats []*domain.Chat
	result := r.db.WithContext(ctx).Where("user_id = ?", userID).Order("created_at DESC").Find(&chats)
	if result.Error != nil {
		return nil, result.Error
	}
	return chats, nil
}
