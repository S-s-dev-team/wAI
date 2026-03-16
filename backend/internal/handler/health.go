package handler

import (
	"net/http"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/labstack/echo/v4"
)

type Health struct {
	usecase *usecase.Health
}

func NewHealth(uc *usecase.Health) *Health {
	return &Health{usecase: uc}
}

func (h *Health) Handle(ctx echo.Context) error {
	output, err := h.usecase.Execute(ctx.Request().Context())
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "health check failed",
		})
	}

	return ctx.JSON(http.StatusOK, api.HealthResponse{
		Status: output.Status,
	})
}
