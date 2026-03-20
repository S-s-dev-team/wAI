package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Insight struct {
	db *gorm.DB
}

func NewInsight(db *gorm.DB) domain.InsightRepository {
	return &Insight{db: db}
}

func (r *Insight) Create(ctx context.Context, insight *domain.Insight) (*domain.Insight, error) {
	result := r.db.WithContext(ctx).Create(insight)
	if result.Error != nil {
		return nil, result.Error
	}
	return insight, nil
}

func (r *Insight) ListByUserID(ctx context.Context, userID uuid.UUID) ([]*domain.Insight, error) {
	var insights []*domain.Insight
	result := r.db.WithContext(ctx).Where("user_id = ?", userID).Order("created_at DESC").Find(&insights)
	if result.Error != nil {
		return nil, result.Error
	}
	return insights, nil
}
