package handler

import (
	"net/http"
	"time"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/labstack/echo/v4"
)

func (s *Server) HealthCheck(ctx echo.Context) error {
	return ctx.JSON(http.StatusOK, api.HealthResponse{
		Status:    api.Healthy,
		Timestamp: time.Now(),
		Version:   "1.0.0",
	})
}
