package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID          uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	FirebaseUID string    `gorm:"uniqueIndex;not null"`
	Email       string    `gorm:"not null"`
	DisplayName string    `gorm:"not null"`
	CreatedAt   time.Time `gorm:"autoCreateTime"`
	UpdatedAt   time.Time `gorm:"autoUpdateTime"`
}

type UserRepository interface {
	Create(ctx context.Context, user *User) (*User, error)
	GetByFirebaseUID(ctx context.Context, firebaseUID string) (*User, error)
	Update(ctx context.Context, user *User) (*User, error)
}
