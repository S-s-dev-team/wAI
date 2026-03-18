package domain

import "time"

type PresetKey struct {
	ID        string    `gorm:"primaryKey;type:varchar(50)"`
	Label     string    `gorm:"type:varchar(100);not null"`
	CreatedAt time.Time
	UpdatedAt time.Time
}
