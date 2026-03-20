package handler

import (
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
		messages[i] = messageToResponse(m)
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
		replies[i] = messageToResponse(r)
	}

	return ctx.JSON(http.StatusOK, api.SendMessageResponse{
		UserMessage: messageToResponse(output.UserMessage),
		Replies:     replies,
	})
}

func messageToResponse(m *domain.Message) api.Message {
	return api.Message{
		Id:         openapi_types.UUID(m.ID),
		ChatId:     openapi_types.UUID(m.ChatID),
		SenderType: api.MessageSenderType(m.SenderType),
		Content:    m.Content,
		CreatedAt:  m.CreatedAt,
	}
}
