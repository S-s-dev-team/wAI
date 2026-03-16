package handler

import (
	"net/http"
	"strings"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/labstack/echo/v4"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

type Login struct {
	usecase *usecase.Login
}

func NewLogin(uc *usecase.Login) *Login {
	return &Login{usecase: uc}
}

func (h *Login) Handle(ctx echo.Context) error {
	authHeader := ctx.Request().Header.Get("Authorization")
	if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
		return ctx.JSON(http.StatusUnauthorized, api.ErrorResponse{
			Code:    401,
			Message: "missing or invalid Authorization header",
		})
	}
	idToken := strings.TrimPrefix(authHeader, "Bearer ")

	output, err := h.usecase.Execute(ctx.Request().Context(), usecase.LoginInput{
		IDToken: idToken,
	})
	if err != nil {
		return ctx.JSON(http.StatusUnauthorized, api.ErrorResponse{
			Code:    401,
			Message: "invalid token",
		})
	}

	email := output.User.Email
	displayName := output.User.DisplayName
	resp := api.LoginResponse{
		Id:          openapi_types.UUID(output.User.ID),
		FirebaseUid: output.User.FirebaseUID,
		Email:       email,
		DisplayName: displayName,
		CreatedAt:   output.User.CreatedAt,
		UpdatedAt:   output.User.UpdatedAt,
	}

	return ctx.JSON(http.StatusOK, resp)
}
