package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Persona struct {
	ID           uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	ChatID       uuid.UUID `gorm:"type:uuid;not null;index"`
	Name         string    `gorm:"not null"`
	PersonaType  string    `gorm:"not null"`
	Age          int
	Gender       string
	Occupation   string
	AnnualIncome int
	SystemPrompt string
	CreatedAt    time.Time `gorm:"autoCreateTime"`
	UpdatedAt    time.Time `gorm:"autoUpdateTime"`
}

type PersonaRepository interface {
	Create(ctx context.Context, persona *Persona) (*Persona, error)
	GetByChatID(ctx context.Context, chatID uuid.UUID) (*Persona, error)
}
