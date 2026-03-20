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

func (s *Server) AnalyzeChat(ctx echo.Context, chatId openapi_types.UUID) error {
	user, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	output, err := s.insightUC.Analyze(ctx.Request().Context(), user.ID, uuid.UUID(chatId))
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to analyze chat",
		})
	}

	insights := make([]api.Insight, len(output.Insights))
	for i, ins := range output.Insights {
		insights[i] = insightToResponse(ins, output.Categories)
	}

	return ctx.JSON(http.StatusOK, api.AnalyzeChatResponse{
		Insights: insights,
	})
}

func (s *Server) GetDashboard(ctx echo.Context) error {
	user, err := s.authenticate(ctx)
	if err != nil {
		return err
	}

	output, err := s.insightUC.GetDashboard(ctx.Request().Context(), user.ID)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, api.ErrorResponse{
			Code:    500,
			Message: "failed to get dashboard",
		})
	}

	categories := make([]api.DashboardCategory, len(output.Categories))
	for i, cat := range output.Categories {
		catInsights := make([]api.Insight, len(cat.Insights))
		for j, ins := range cat.Insights {
			catInsights[j] = insightToResponse(ins, output.AllCategories)
		}
		categories[i] = api.DashboardCategory{
			CategoryKey: cat.CategoryKey,
			DisplayName: cat.DisplayName,
			Insights:    catInsights,
		}
	}

	recentInsights := make([]api.Insight, len(output.RecentInsights))
	for i, ins := range output.RecentInsights {
		recentInsights[i] = insightToResponse(ins, output.AllCategories)
	}

	return ctx.JSON(http.StatusOK, api.DashboardResponse{
		Categories:     categories,
		RecentInsights: recentInsights,
		TotalCount:     output.TotalCount,
	})
}

func insightToResponse(ins *domain.Insight, categories map[uuid.UUID]*domain.InsightCategory) api.Insight {
	resp := api.Insight{
		Id:        openapi_types.UUID(ins.ID),
		Content:   ins.Content,
		CreatedAt: ins.CreatedAt,
	}

	if cat, ok := categories[ins.CategoryID]; ok {
		resp.CategoryKey = cat.CategoryKey
		resp.CategoryDisplayName = cat.DisplayName
	}

	if ins.ChatID != nil {
		chatID := openapi_types.UUID(*ins.ChatID)
		resp.ChatId = &chatID
	}

	return resp
}

// insightUC field is used via the usecase package
var _ = (*usecase.InsightUsecase)(nil)
