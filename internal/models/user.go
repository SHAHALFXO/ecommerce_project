package models

import "time"

type User struct{
	ID int                `gorm:"primaryKey" json:"id"`
	Email string          `gorm:"uniqueIndex;not null" json:"email"`
	PasswordHash string   `gorm:"not null" json:"-"`
	Role string           `gorm:"default:'customer';not null" json:"role"`
    IsActive bool        `gorm:"default:true" json:"is_active"`
	CreatedAt time.Time   `gorm:"autoCreateTime" json:"created_at"`
	UpdatedAt time.Time   `gorm:"autoUpdateTime" json:"updated_at"`
}