package handler

import (
	"context"
	"net/http"

	"github.com/S-s-dev-team/wAI/internal/api"
	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/S-s-dev-team/wAI/internal/usecase"
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

func (s *Server) ListMessages(ctx echo.Context, chatId openapi_types.UUID, params api.ListMessagesParams) error {
	_, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	limit := 50
	if params.Limit != nil {
		limit = *params.Limit
	}

	var before *uuid.UUID
	if params.Before != nil {
		id := uuid.UUID(*params.Before)
		before = &id
	}

	output, err := s.messageUC.List(ctx.Request().Context(), usecase.ListMessagesInput{
		ChatID: uuid.UUID(chatId),
		Limit:  limit,
		Before: before,
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to list messages",
		})
	}

	messages := make([]api.Message, len(output.Messages))
	for i, m := range output.Messages {
		messages[i] = s.messageToResponse(ctx.Request().Context(), m)
	}

	return ctx.JSON(http.StatusOK, api.MessageList{
		Messages: messages,
		HasMore:  output.HasMore,
	})
}

func (s *Server) SendMessage(ctx echo.Context, chatId openapi_types.UUID) error {
	_, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	var req api.SendMessageRequest
	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, api.ErrorResponse{
			Code:    400,
			Message: "invalid request",
		})
	}

	output, err := s.messageUC.Send(ctx.Request().Context(), usecase.SendMessageInput{
		ChatID:  uuid.UUID(chatId),
		Content: req.Content,
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to send message",
		})
	}

	replies := make([]api.Message, len(output.Replies))
	for i, r := range output.Replies {
		replies[i] = s.messageToResponse(ctx.Request().Context(), r)
	}

	return ctx.JSON(http.StatusOK, api.SendMessageResponse{
		UserMessage: s.messageToResponse(ctx.Request().Context(), output.UserMessage),
		Replies:     replies,
	})
}

func (s *Server) CallPersona(ctx echo.Context, chatId openapi_types.UUID) error {
	_, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	var req api.CallPersonaRequest
	if err := ctx.Bind(&req); err != nil {
		return ctx.JSON(http.StatusBadRequest, api.ErrorResponse{
			Code:    400,
			Message: "invalid request",
		})
	}

	msg, err := s.messageUC.CallPersona(ctx.Request().Context(), usecase.CallPersonaInput{
		ChatID:    uuid.UUID(chatId),
		PresetKey: string(req.PresetKey),
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to call persona",
		})
	}

	return ctx.JSON(http.StatusCreated, s.messageToResponse(ctx.Request().Context(), msg))
}

func (s *Server) messageToResponse(ctx context.Context, m *domain.Message) api.Message {
	msg := api.Message{
		Id:         openapi_types.UUID(m.ID),
		ChatId:     openapi_types.UUID(m.ChatID),
		SenderType: api.MessageSenderType(m.SenderType),
		Content:    m.Content,
		CreatedAt:  m.CreatedAt,
	}

	if m.PersonaID != nil {
		persona, err := s.personaRepo.GetByID(ctx, *m.PersonaID)
		if err == nil && persona != nil {
			p := personaToResponse(persona)
			msg.Persona = &p
		}
	}

	return msg
}

func personaToResponse(p *domain.Persona) api.Persona {
	resp := api.Persona{
		Id:          openapi_types.UUID(p.ID),
		Name:        p.Name,
		PersonaType: api.PersonaPersonaType(p.PersonaType),
	}
	if p.PresetKeyID != nil {
		resp.PresetKeyId = p.PresetKeyID
	}
	if p.Age != nil {
		resp.Age = p.Age
	}
	if p.AnnualIncome != nil {
		resp.AnnualIncome = p.AnnualIncome
	}
	if p.Gender != nil {
		resp.Gender = p.Gender
	}
	if p.Occupation != nil {
		resp.Occupation = p.Occupation
	}
	return resp
}
