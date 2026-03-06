package models

type CartItem struct {
	ID        uint `gorm:"primaryKey"`
	CartID    uint
	ProductID uint
	Product   Product `gorm:"foreignKey:ProductID"`
	Quantity  int
	Price     float64
}
