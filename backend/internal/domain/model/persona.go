package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Persona struct {
	ID           uuid.UUID  `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	UserID       *uuid.UUID `gorm:"type:uuid;index"`
	ChatID       *uuid.UUID `gorm:"type:uuid;index"`
	PersonaType  string     `gorm:"type:varchar(10);not null"`
	PresetKeyID  *string    `gorm:"type:varchar(50)"`
	Name         string     `gorm:"type:varchar(100);not null"`
	Gender       *string    `gorm:"type:varchar(20)"`
	Age          *int
	Occupation   *string    `gorm:"type:varchar(100)"`
	AnnualIncome *int
	SystemPrompt string     `gorm:"type:text;not null"`
	CreatedAt    time.Time  `gorm:"autoCreateTime"`
	UpdatedAt    time.Time  `gorm:"autoUpdateTime"`
}

type PersonaRepository interface {
	Create(ctx context.Context, persona *Persona) (*Persona, error)
	GetByID(ctx context.Context, id uuid.UUID) (*Persona, error)
	GetByChatID(ctx context.Context, chatID uuid.UUID) (*Persona, error)
	GetByPresetKey(ctx context.Context, key string) (*Persona, error)
}
