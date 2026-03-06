package models

type UserAddress struct {
	ID        uint   `gorm:"primaryKey"`
	UserID    uint   `gorm:"not null;index"`
	Address1  string `gorm:"not null"`
	City      string `gorm:"not null"`
	State     string `gorm:"not null"`
	Pincode   string `gorm:"not null"`
	Country   string `gorm:"default:'India'"`
	IsDefault bool   `gorm:"default:false"`
}
