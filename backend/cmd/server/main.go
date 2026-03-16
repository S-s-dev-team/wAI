package main

import (
	"context"
	"log"

	"github.com/S-s-dev-team/wAI/internal/api"
	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/S-s-dev-team/wAI/registry"
	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Println(".env file not found")
	}

	ctx := context.Background()

	app, err := registry.InitializeApp(ctx)
	if err != nil {
		log.Fatalf("failed to initialize app: %v", err)
	}

	// マイグレーション
	if err := app.DB.AutoMigrate(&domain.User{}, &domain.Chat{}); err != nil {
		log.Fatalf("failed to migrate: %v", err)
	}

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// OpenAPI で定義された全ルートを登録
	api.RegisterHandlers(e, app.Server)

	e.Logger.Fatal(e.Start(":8080"))
}
