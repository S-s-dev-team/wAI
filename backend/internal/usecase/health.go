package usecase

import (
	"context"

	"github.com/S-s-dev-team/wAI/internal/api"
)

type Health struct{}

func NewHealth() *Health {
	return &Health{}
}

type HealthOutput struct {
	Status api.HealthResponseStatus
}

func (u *Health) Execute(ctx context.Context) (*HealthOutput, error) {
	return &HealthOutput{Status: api.Healthy}, nil
}
