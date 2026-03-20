package domain

import (
	"context"

	"github.com/google/uuid"
)

type InsightCategory struct {
	ID          uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	CategoryKey string    `gorm:"type:varchar(50);uniqueIndex;not null"`
	DisplayName string    `gorm:"type:varchar(50);not null"`
	Description *string   `gorm:"type:text"`
}

type InsightCategoryRepository interface {
	List(ctx context.Context) ([]*InsightCategory, error)
	GetByKey(ctx context.Context, key string) (*InsightCategory, error)
}
