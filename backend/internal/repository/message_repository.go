package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Message struct {
	db *gorm.DB
}

func NewMessage(db *gorm.DB) domain.MessageRepository {
	return &Message{db: db}
}

func (r *Message) Create(ctx context.Context, message *domain.Message) (*domain.Message, error) {
	result := r.db.WithContext(ctx).Create(message)
	if result.Error != nil {
		return nil, result.Error
	}
	return message, nil
}

func (r *Message) ListByChatID(ctx context.Context, chatID uuid.UUID, limit int, before *uuid.UUID) ([]*domain.Message, error) {
	query := r.db.WithContext(ctx).Where("chat_id = ?", chatID)

	if before != nil {
		var beforeMsg domain.Message
		if err := r.db.WithContext(ctx).Where("id = ?", *before).First(&beforeMsg).Error; err == nil {
			query = query.Where("created_at < ?", beforeMsg.CreatedAt)
		}
	}

	var messages []*domain.Message
	result := query.Order("created_at ASC").Limit(limit).Find(&messages)
	if result.Error != nil {
		return nil, result.Error
	}
	return messages, nil
}
