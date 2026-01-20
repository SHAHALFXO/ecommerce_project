package models

type Cart struct {
	ID     uint `gorm:"primaryKey"`
	UserID uint
	Status string
	Items  []CartItem `gorm:"foreignKey:CartID"`
}
