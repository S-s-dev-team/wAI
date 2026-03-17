package handler

import (
	"net/http"
	"strings"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/labstack/echo/v4"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

func (s *Server) Login(ctx echo.Context) error {
	authHeader := ctx.Request().Header.Get("Authorization")
	if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
		return ctx.JSON(http.StatusUnauthorized, api.ErrorResponse{
			Code:    401,
			Message: "missing or invalid Authorization header",
		})
	}
	idToken := strings.TrimPrefix(authHeader, "Bearer ")

	output, err := s.loginUC.Execute(ctx.Request().Context(), usecase.LoginInput{
		IDToken: idToken,
	})
	if err != nil {
		return ctx.JSON(http.StatusUnauthorized, api.ErrorResponse{
			Code:    401,
			Message: "invalid token",
		})
	}

	return ctx.JSON(http.StatusOK, api.LoginResponse{
		Id:          openapi_types.UUID(output.User.ID),
		FirebaseUid: output.User.FirebaseUID,
		Email:       output.User.Email,
		DisplayName: output.User.DisplayName,
		CreatedAt:   output.User.CreatedAt,
		UpdatedAt:   output.User.UpdatedAt,
	})
}
