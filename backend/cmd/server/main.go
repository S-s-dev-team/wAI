package main

import (
	"context"
	"log"

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
	if err := app.DB.AutoMigrate(&domain.User{}); err != nil {
		log.Fatalf("failed to migrate: %v", err)
	}

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/health", app.HealthHandler.Handle)
	e.POST("/login", app.LoginHandler.Handle)

	e.Logger.Fatal(e.Start(":8080"))
}
