package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID          uuid.UUID `gorm:"primaryKey"`
	FirebaseUID string    `gorm:"uniqueIndex;not null"`
	Email       string    `gorm:"not null"`
	DisplayName string    `gorm:"not null"`
	CreatedAt   time.Time `gorm:"autoCreateTime"`
	UpdatedAt   time.Time `gorm:"autoUpdateTime"`
}

type UserRepository interface {
	UpsertUser(ctx context.Context, firebaseUID string, email, displayName *string) (*User, error)
	GetUserByFirebaseUID(ctx context.Context, firebaseUID string) (*User, error)
}
