package registry

import (
	"context"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"github.com/S-s-dev-team/wAI/internal/domain/config"
	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func FirebaseAuthProvider(ctx context.Context, cfg *config.Vars) (*auth.Client, error) {
	app, err := firebase.NewApp(ctx, &firebase.Config{
		ProjectID: cfg.FirebaseAuthProjectID,
	})
	if err != nil {
		return nil, err
	}
	return app.Auth(ctx)
}

func GeminiAPIProvider(ctx context.Context, cfg *config.Vars) (*genai.Client, error) {
	client, err := genai.NewClient(ctx, option.WithAPIKey(cfg.GeminiAPIKey))
	if err != nil {
		return nil, err
	}
	return client, nil
}

func DatabaseProvider(cfg *config.Vars) (*gorm.DB, error) {
	dsn := cfg.Database.DataSourceName()
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return nil, err
	}
	return db, nil
}