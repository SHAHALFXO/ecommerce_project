package repo

import (
	"ecommerce_project/internal/models"
	"errors"

	"gorm.io/gorm"
)

type CartRepo struct {
	db *gorm.DB
}

func NewCartRepo(db *gorm.DB) *CartRepo {
	return &CartRepo{db: db}
}

func (r *CartRepo) GetOrCreateCart(userID uint) (*models.Cart, error) {
	var cart models.Cart

	err := r.db.
		Where("user_id = ? AND status = ?", userID, "active").
		First(&cart).Error

	if errors.Is(err, gorm.ErrRecordNotFound) {
		cart = models.Cart{
			UserID: userID,
			Status: "active",
		}
		if err := r.db.Create(&cart).Error; err != nil {
			return nil, err
		}
		return &cart, nil
	}

	return &cart, err
}

func (r *CartRepo) GetCartByUserID(userID uint) (*models.Cart, error) {
	var cart models.Cart

	err := r.db.
		Where("user_id = ?", userID).
		First(&cart).Error

	if err != nil {
		return nil, err
	}

	return &cart, nil
}

func (r *CartRepo) DeleteCart(cartID uint) error {
    return r.db.
        Where("id = ?", cartID).
        Delete(&models.Cart{}).
        Error
}
