package handler

import (
	"net/http"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/labstack/echo/v4"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

func (s *Server) ListMessages(ctx echo.Context, chatId openapi_types.UUID, params api.ListMessagesParams) error {
	return ctx.JSON(http.StatusNotImplemented, api.ErrorResponse{
		Code:    501,
		Message: "not implemented",
	})
}

func (s *Server) SendMessage(ctx echo.Context, chatId openapi_types.UUID) error {
	return ctx.JSON(http.StatusNotImplemented, api.ErrorResponse{
		Code:    501,
		Message: "not implemented",
	})
}
