package usecase

import (
	"context"
	"errors"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"gorm.io/gorm"
)

type Login struct {
	authRepository domain.AuthRepository
	userRepository domain.UserRepository
}

func NewLogin(authRepository domain.AuthRepository, userRepository domain.UserRepository) *Login {
	return &Login{
		authRepository: authRepository,
		userRepository: userRepository,
	}
}

type LoginInput struct {
	IDToken string
}

type LoginOutput struct {
	User *domain.User
}

func (u *Login) Execute(ctx context.Context, input LoginInput) (*LoginOutput, error) {
	tokenInfo, err := u.authRepository.VerifyIDToken(ctx, input.IDToken)
	if err != nil {
		return nil, err
	}

	user, err := u.userRepository.GetByFirebaseUID(ctx, tokenInfo.UID)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		user, err = u.userRepository.Create(ctx, &domain.User{
			FirebaseUID: tokenInfo.UID,
			Email:       tokenInfo.Email,
			DisplayName: tokenInfo.DisplayName,
		})
		if err != nil {
			return nil, err
		}
		return &LoginOutput{User: user}, nil
	}
	if err != nil {
		return nil, err
	}
	
	user.Email = tokenInfo.Email
	user.DisplayName = tokenInfo.DisplayName
	user, err = u.userRepository.Update(ctx, user)
	if err != nil {
		return nil, err
	}

	return &LoginOutput{User: user}, nil
}
