package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Message struct {
	ID         uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	ChatID     uuid.UUID `gorm:"type:uuid;not null;index"`
	SenderType string    `gorm:"not null"` // "user" or "persona"
	Content    string    `gorm:"not null"`
	CreatedAt  time.Time `gorm:"autoCreateTime"`
}

type MessageRepository interface {
	Create(ctx context.Context, message *Message) (*Message, error)
	ListByChatID(ctx context.Context, chatID uuid.UUID, limit int, before *uuid.UUID) ([]*Message, error)
}
