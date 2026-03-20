package main

import (
	"context"
	"log"

	"github.com/S-s-dev-team/wAI/internal/api"
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

	if err := Migrate(app.DB); err != nil {
		log.Fatalf("failed to migrate: %v", err)
	}

	Seed(app.DB)

	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	api.RegisterHandlers(e, app.Server)

	e.Logger.Fatal(e.Start(":8080"))
}
