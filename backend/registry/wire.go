//go:build wireinject
// +build wireinject

package registry

import (
	"context"

	"github.com/S-s-dev-team/wAI/internal/domain/config"
	"github.com/S-s-dev-team/wAI/internal/handler"
	"github.com/S-s-dev-team/wAI/internal/repository"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/google/generative-ai-go/genai"
	"github.com/google/wire"
	"gorm.io/gorm"
)

type App struct {
	LoginHandler  *handler.Login
	HealthHandler *handler.Health
	DB            *gorm.DB
	GenAI         *genai.Client
}

func InitializeApp(ctx context.Context) (*App, error) {
	wire.Build(
		FirebaseAuthProvider,
		GeminiAPIProvider,
		DatabaseProvider,
		config.New,
		repository.NewAuth,
		repository.NewUser,
		usecase.NewLogin,
		usecase.NewHealth,
		handler.NewLogin,
		handler.NewHealth,
		wire.Struct(new(App), "*"),
	)
	return nil, nil
}
