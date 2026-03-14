package main

import (
	"net/http"
	"time"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type Handler struct{}

func (h *Handler) HealthCheck(ctx echo.Context) error {
	response := api.HealthResponse{
		Status:    api.Healthy,
		Timestamp: time.Now(),
		Version:   "1.0.0",
	}
	return ctx.JSON(http.StatusOK, response)
}

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	handler := &Handler{}
	api.RegisterHandlers(e, handler)

	e.Logger.Fatal(e.Start(":8080"))
}
