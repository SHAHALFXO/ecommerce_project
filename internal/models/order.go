package models

import "time"

type Order struct {
	ID        uint      `gorm:"primaryKey"`
	UserID    uint
	Status    string    // pending, paid, cancelled
	Total     float64
	CreatedAt time.Time
	OrderItems []OrderItem `gorm:"foreignKey:OrderID"`
}
