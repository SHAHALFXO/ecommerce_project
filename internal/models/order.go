package models

import "time"

type Order struct {
	ID                uint        `gorm:"primaryKey" json:"id"`
	UserID            uint        `json:"user_id"`
	Status            string      `json:"status"`
	Total             float64     `json:"total"`
	CreatedAt         time.Time   `json:"created_at"`
	OrderItems        []OrderItem `gorm:"foreignKey:OrderID" json:"order_items"`
	RazorpayOrderID   string      `gorm:"type:varchar(100);index" json:"razorpay_order_id"`
	RazorpayPaymentID string      `gorm:"type:varchar(100);index" json:"razorpay_payment_id"`
	PaymentStatus     string      `gorm:"type:varchar(20);default:'pending'" json:"payment_status"` 
}
