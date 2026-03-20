package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"gorm.io/gorm"
)

type InsightCategory struct {
	db *gorm.DB
}

func NewInsightCategory(db *gorm.DB) domain.InsightCategoryRepository {
	return &InsightCategory{db: db}
}

func (r *InsightCategory) List(ctx context.Context) ([]*domain.InsightCategory, error) {
	var categories []*domain.InsightCategory
	result := r.db.WithContext(ctx).Find(&categories)
	if result.Error != nil {
		return nil, result.Error
	}
	return categories, nil
}

func (r *InsightCategory) GetByKey(ctx context.Context, key string) (*domain.InsightCategory, error) {
	var category domain.InsightCategory
	result := r.db.WithContext(ctx).Where("category_key = ?", key).First(&category)
	if result.Error != nil {
		return nil, result.Error
	}
	return &category, nil
}
