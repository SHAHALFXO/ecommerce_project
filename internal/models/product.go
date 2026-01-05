package models

import (
	"time"
)

type Product struct {
	ID          uint    `gorm:"primaryKey" json:"id"`
	Name        string  `gorm:"not null" json:"name"`
	Price       float64 `gorm:"not null" json:"price"`
	Stock       int     `gorm:"not null" json:"stock"`
	Description string  `json:"description"`
	Category  string    `json:"category"`
	ImageURL  string    `json:"image_url"`
	CreatedAt time.Time `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt time.Time `gorm:"autoUpdateTime" json:"updated_at"`
}
