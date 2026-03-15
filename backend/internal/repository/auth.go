package repository

import (
	"context"

	"firebase.google.com/go/v4/auth"
	"github.com/S-s-dev-team/wAI/internal/domain"
)

type Auth struct {
	client *auth.Client
}

func NewAuth(client *auth.Client) domain.AuthRepository {
	return &Auth{client: client}
}

func (r *Auth) VerifyIDToken(ctx context.Context, idToken string) (*domain.TokenInfo, error) {
	token, err := r.client.VerifyIDToken(ctx, idToken)
	if err != nil {
		return nil, err
	}

	email, _ := token.Claims["email"].(string)
	displayName, _ := token.Claims["name"].(string)

	return &domain.TokenInfo{
		UID:         token.UID,
		Email:       email,
		DisplayName: displayName,
	}, nil
}
