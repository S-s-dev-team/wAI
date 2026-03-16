package domain

import "context"

type TokenInfo struct {
	UID         string
	Email       string
	DisplayName string
}

type AuthRepository interface {
	VerifyIDToken(ctx context.Context, idToken string) (*TokenInfo, error)
}
