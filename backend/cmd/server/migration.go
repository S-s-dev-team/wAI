package main

import (
	domain "github.com/S-s-dev-team/wAI/internal/domain/model"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func Migrate(db *gorm.DB) error {
	return db.AutoMigrate(
		&domain.User{},
		&domain.Chat{},
		&domain.PresetKey{},
		&domain.Persona{},
		&domain.ChatParticipant{},
		&domain.Message{},
		&domain.InsightCategory{},
		&domain.Insight{},
	)
}

func Seed(db *gorm.DB) {
	seedInsightCategories(db)
	seedPresetKeys(db)
	seedPresetPersonas(db)
}

func seedInsightCategories(db *gorm.DB) {
	categories := []domain.InsightCategory{
		{CategoryKey: "values", DisplayName: "価値観", Description: strPtr("仕事や人生において大切にしていること")},
		{CategoryKey: "strengths", DisplayName: "強み", Description: strPtr("自分の得意なこと・優れている点")},
		{CategoryKey: "weaknesses", DisplayName: "弱み", Description: strPtr("自分の苦手なこと・改善が必要な点")},
		{CategoryKey: "suitable_jobs", DisplayName: "向いている職種", Description: strPtr("適性があると考えられる仕事・職種")},
		{CategoryKey: "interests", DisplayName: "興味・関心", Description: strPtr("興味を持っている分野やテーマ")},
	}
	for _, c := range categories {
		db.Where("category_key = ?", c.CategoryKey).FirstOrCreate(&c)
	}
}

func seedPresetKeys(db *gorm.DB) {
	presetKeys := []domain.PresetKey{
		{ID: "yarigai", Label: "やりがい重視"},
		{ID: "nenshu", Label: "年収重視"},
	}
	for _, pk := range presetKeys {
		db.Clauses(clause.OnConflict{DoNothing: true}).Create(&pk)
	}
}

func seedPresetPersonas(db *gorm.DB) {
	presetPersonas := []struct {
		PresetKeyID  string
		Name         string
		SystemPrompt string
	}{
		{
			PresetKeyID: "yarigai",
			Name:        "やりがい重視先輩",
			SystemPrompt: "仕事のやりがいや成長を最優先に考える社会人の先輩です。\n" +
				"給与よりも「仕事の意味」「社会貢献」「自己成長」を重視した視点でアドバイスをしてください。\n" +
				"就活生の価値観を引き出すような質問を積極的にしてください。",
		},
		{
			PresetKeyID: "nenshu",
			Name:        "年収重視先輩",
			SystemPrompt: "年収・キャリアアップ・市場価値を最優先に考える社会人の先輩です。\n" +
				"やりがいよりも「稼ぐ力」「スキルの市場価値」「昇給・転職のしやすさ」を重視した視点でアドバイスをしてください。\n" +
				"就活生が自分の強みを経済的価値で評価できるよう導いてください。",
		},
	}

	for _, pp := range presetPersonas {
		var count int64
		db.Model(&domain.Persona{}).Where("persona_type = ? AND preset_key_id = ?", "preset", pp.PresetKeyID).Count(&count)
		if count == 0 {
			key := pp.PresetKeyID
			db.Create(&domain.Persona{
				PersonaType:  "preset",
				PresetKeyID:  &key,
				Name:         pp.Name,
				SystemPrompt: pp.SystemPrompt,
			})
		}
	}
}

func strPtr(s string) *string {
	return &s
}
