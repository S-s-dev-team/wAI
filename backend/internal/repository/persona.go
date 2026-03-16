package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Persona struct {
	db *gorm.DB
}

func NewPersona(db *gorm.DB) domain.PersonaRepository {
	return &Persona{db: db}
}

func (r *Persona) Create(ctx context.Context, persona *domain.Persona) (*domain.Persona, error) {
	result := r.db.WithContext(ctx).Create(persona)
	if result.Error != nil {
		return nil, result.Error
	}
	return persona, nil
}

func (r *Persona) GetByChatID(ctx context.Context, chatID uuid.UUID) (*domain.Persona, error) {
	var persona domain.Persona
	result := r.db.WithContext(ctx).Where("chat_id = ?", chatID).First(&persona)
	if result.Error != nil {
		return nil, result.Error
	}
	return &persona, nil
}
