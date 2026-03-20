package domain

import "context"

type ChatMessage struct {
	Role    string // "user" or "model"
	Content string
}

type AIRequest struct {
	Model        string // モデル名（空の場合はデフォルトを使用）
	SystemPrompt string
	History      []ChatMessage
	UserMessage  string
}

type AIResponse struct {
	Content      string
	PromptTokens int32
	ReplyTokens  int32
	TotalTokens  int32
}

type AIRepository interface {
	SendMessage(ctx context.Context, req *AIRequest) (*AIResponse, error)
}
