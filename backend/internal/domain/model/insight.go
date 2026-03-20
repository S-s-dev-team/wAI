package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Insight struct {
	ID         uuid.UUID  `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	UserID     uuid.UUID  `gorm:"type:uuid;not null;index"`
	ChatID     *uuid.UUID `gorm:"type:uuid"`
	CategoryID uuid.UUID  `gorm:"type:uuid;not null"`
	Content    string     `gorm:"type:text;not null"`
	CreatedAt  time.Time  `gorm:"autoCreateTime"`
}

type InsightRepository interface {
	Create(ctx context.Context, insight *Insight) (*Insight, error)
	ListByUserID(ctx context.Context, userID uuid.UUID) ([]*Insight, error)
}
