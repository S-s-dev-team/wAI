package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Chat struct {
	ID        uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	UserID    uuid.UUID `gorm:"type:uuid;not null;index"`
	Title     string    `gorm:"not null"`
	CreatedAt time.Time `gorm:"autoCreateTime"`
	UpdatedAt time.Time `gorm:"autoUpdateTime"`
}

type ChatRepository interface {
	Create(ctx context.Context, chat *Chat) (*Chat, error)
	GetByID(ctx context.Context, id uuid.UUID) (*Chat, error)
	ListByUserID(ctx context.Context, userID uuid.UUID) ([]*Chat, error)
}
