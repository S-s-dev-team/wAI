package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID           uuid.UUID
	FirebaseUID  string
	Email        string
	DisplayName  string
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

type UserRepository interface {
	UpsertUser(ctx context.Context, firebaseUID string, email, displayName *string) (*User, error)
	GetUserByFirebaseUID(ctx context.Context, firebaseUID string) (*User, error)
}
