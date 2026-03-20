package handler

import (
	"net/http"

	"github.com/S-s-dev-team/wAI/internal/api"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/labstack/echo/v4"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

func (s *Server) CreateChat(ctx echo.Context) error {
	user, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	var req api.CreateChatRequest
	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, api.ErrorResponse{
			Code:    400,
			Message: "invalid request",
		})
	}

	title := "New Chat"
	if req.Title != nil {
		title = *req.Title
	}

	systemPrompt := ""
	if req.Persona.SystemPrompt != nil {
		systemPrompt = *req.Persona.SystemPrompt
	}

	output, err := s.chatUC.Create(ctx.Request().Context(), usecase.CreateChatInput{
		UserID:       user.ID,
		Title:        title,
		PersonaName:  req.Persona.Name,
		PersonaType:  "custom",
		Age:          req.Persona.Age,
		Gender:       req.Persona.Gender,
		Occupation:   req.Persona.Occupation,
		AnnualIncome: req.Persona.AnnualIncome,
		SystemPrompt: systemPrompt,
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to create chat",
		})
	}

	return ctx.JSON(http.StatusCreated, chatToResponse(output))
}

func (s *Server) ListChats(ctx echo.Context) error {
	user, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	output, err := s.chatUC.ListByUserID(ctx.Request().Context(), user.ID)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to list chats",
		})
	}

	chats := make([]api.Chat, len(output.Chats))
	for i, c := range output.Chats {
		title := c.Title
		chat := api.Chat{
			Id:        openapi_types.UUID(c.ID),
			Title:     &title,
			CreatedAt: c.CreatedAt,
			UpdatedAt: c.UpdatedAt,
		}
		if p, ok := output.Personas[c.ID]; ok {
			resp := personaToResponse(p)
			chat.Persona = resp
		}
		chats[i] = chat
	}

	return ctx.JSON(http.StatusOK, chats)
}

func chatToResponse(output *usecase.ChatOutput) api.Chat {
	title := output.Chat.Title
	chat := api.Chat{
		Id:        openapi_types.UUID(output.Chat.ID),
		Title:     &title,
		CreatedAt: output.Chat.CreatedAt,
		UpdatedAt: output.Chat.UpdatedAt,
	}
	if output.Persona != nil {
		chat.Persona = personaToResponse(output.Persona)
	}
	return chat
}
