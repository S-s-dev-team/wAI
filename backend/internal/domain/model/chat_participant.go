package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type ChatParticipant struct {
	ID        uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	ChatID    uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:idx_chat_persona"`
	PersonaID uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:idx_chat_persona"`
	JoinedAt  time.Time `gorm:"autoCreateTime"`
}

type ChatParticipantRepository interface {
	Create(ctx context.Context, participant *ChatParticipant) (*ChatParticipant, error)
	ListByChatID(ctx context.Context, chatID uuid.UUID) ([]*ChatParticipant, error)
}
