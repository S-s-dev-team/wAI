package handler

import (
	"net/http"
	"strings"

	"github.com/S-s-dev-team/wAI/internal/api"
	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/labstack/echo/v4"
)

type Server struct {
	authRepo    domain.AuthRepository
	userRepo    domain.UserRepository
	personaRepo domain.PersonaRepository
	loginUC     *usecase.Login
	chatUC      *usecase.ChatUsecase
	messageUC   *usecase.MessageUsecase
}

func NewServer(
	authRepo domain.AuthRepository,
	userRepo domain.UserRepository,
	personaRepo domain.PersonaRepository,
	loginUC *usecase.Login,
	chatUC *usecase.ChatUsecase,
	messageUC *usecase.MessageUsecase,
) *Server {
	return &Server{
		authRepo:    authRepo,
		userRepo:    userRepo,
		personaRepo: personaRepo,
		loginUC:     loginUC,
		chatUC:      chatUC,
		messageUC:   messageUC,
	}
}

func (s *Server) authenticate(ctx echo.Context) (*domain.User, error) {
	authHeader := ctx.Request().Header.Get("Authorization")
	if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
		return nil, echo.NewHTTPError(http.StatusUnauthorized, "missing token")
	}
	idToken := strings.TrimPrefix(authHeader, "Bearer ")

	tokenInfo, err := s.authRepo.VerifyIDToken(ctx.Request().Context(), idToken)
	if err != nil {
		return nil, echo.NewHTTPError(http.StatusUnauthorized, "invalid token")
	}

	user, err := s.userRepo.GetByFirebaseUID(ctx.Request().Context(), tokenInfo.UID)
	if err != nil {
		return nil, echo.NewHTTPError(http.StatusUnauthorized, "user not found")
	}

	return user, nil
}

var _ api.ServerInterface = (*Server)(nil)
