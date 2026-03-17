package usecase

import (
	"context"

	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"github.com/google/uuid"
)

type ChatUsecase struct {
	chatRepository    domain.ChatRepository
	personaRepository domain.PersonaRepository
}

func NewChatUsecase(chatRepository domain.ChatRepository, personaRepository domain.PersonaRepository) *ChatUsecase {
	return &ChatUsecase{
		chatRepository:    chatRepository,
		personaRepository: personaRepository,
	}
}

type CreateChatInput struct {
	UserID       uuid.UUID
	Title        string
	PersonaName  string
	PersonaType  string
	Age          int
	Gender       string
	Occupation   string
	AnnualIncome int
	SystemPrompt string
}

type ChatOutput struct {
	Chat    *domain.Chat
	Persona *domain.Persona
}

type ChatListOutput struct {
	Chats    []*domain.Chat
	Personas map[uuid.UUID]*domain.Persona
}

func (u *ChatUsecase) Create(ctx context.Context, input CreateChatInput) (*ChatOutput, error) {
	chat, err := u.chatRepository.Create(ctx, &domain.Chat{
		UserID: input.UserID,
		Title:  input.Title,
	})
	if err != nil {
		return nil, err
	}

	//TODO(seba): ハンドラーからシステムプロンプトはnilでくる想定何だけど、ここでプロンプトをペルソナから作って欲しい。
	// go tempalte packageとかを使ってpersona情報からプロンプトを作るみたいな。
	//イメージとしては、persona構造体を渡すと、systemPrompを作ってくれる関数みたいなのを作るみたいな。

	// generatedSystemPrompt := genPrompt(input.Persona) //どこかで関数作る

	persona, err := u.personaRepository.Create(ctx, &domain.Persona{
		ChatID:       chat.ID,
		Name:         input.PersonaName,
		PersonaType:  input.PersonaType,
		Age:          input.Age,
		Gender:       input.Gender,
		Occupation:   input.Occupation,
		AnnualIncome: input.AnnualIncome,
		SystemPrompt: input.SystemPrompt, //generatedSystemPromptを入れる
	})
	if err != nil {
		return nil, err
	}

	return &ChatOutput{Chat: chat, Persona: persona}, nil
}

func (u *ChatUsecase) GetByID(ctx context.Context, id uuid.UUID) (*ChatOutput, error) {
	chat, err := u.chatRepository.GetByID(ctx, id)
	if err != nil {
		return nil, err
	}
	persona, _ := u.personaRepository.GetByChatID(ctx, id)
	return &ChatOutput{Chat: chat, Persona: persona}, nil
}

func (u *ChatUsecase) ListByUserID(ctx context.Context, userID uuid.UUID) (*ChatListOutput, error) {
	chats, err := u.chatRepository.ListByUserID(ctx, userID)
	if err != nil {
		return nil, err
	}

	personas := make(map[uuid.UUID]*domain.Persona)
	for _, c := range chats {
		p, _ := u.personaRepository.GetByChatID(ctx, c.ID)
		if p != nil {
			personas[c.ID] = p
		}
	}

	return &ChatListOutput{Chats: chats, Personas: personas}, nil
}
