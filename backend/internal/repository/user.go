package repository

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"gorm.io/gorm"
)

type User struct {
	db *gorm.DB
}

func NewUser(db *gorm.DB) domain.UserRepository {
	return &User{db: db}
}

func (r *User) Create(ctx context.Context, user *domain.User) (*domain.User, error) {
	result := r.db.WithContext(ctx).Create(user)
	if result.Error != nil {
		return nil, result.Error
	}
	return user, nil
}

func (r *User) GetByFirebaseUID(ctx context.Context, firebaseUID string) (*domain.User, error) {
	var user domain.User
	result := r.db.WithContext(ctx).Where("firebase_uid = ?", firebaseUID).First(&user)
	if result.Error != nil {
		return nil, result.Error
	}
	return &user, nil
}

func (r *User) Update(ctx context.Context, user *domain.User) (*domain.User, error) {
	result := r.db.WithContext(ctx).Save(user)
	if result.Error != nil {
		return nil, result.Error
	}
	return user, nil
}
