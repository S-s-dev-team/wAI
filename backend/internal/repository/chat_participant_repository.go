package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ChatParticipant struct {
	db *gorm.DB
}

func NewChatParticipant(db *gorm.DB) domain.ChatParticipantRepository {
	return &ChatParticipant{db: db}
}

func (r *ChatParticipant) Create(ctx context.Context, participant *domain.ChatParticipant) (*domain.ChatParticipant, error) {
	result := r.db.WithContext(ctx).Create(participant)
	if result.Error != nil {
		return nil, result.Error
	}
	return participant, nil
}

func (r *ChatParticipant) ListByChatID(ctx context.Context, chatID uuid.UUID) ([]*domain.ChatParticipant, error) {
	var participants []*domain.ChatParticipant
	result := r.db.WithContext(ctx).Where("chat_id = ?", chatID).Find(&participants)
	if result.Error != nil {
		return nil, result.Error
	}
	return participants, nil
}
