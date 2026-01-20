package repo

import (
	"ecommerce_project/internal/models"
	"gorm.io/gorm"
)

type CartItemRepo struct {
	db *gorm.DB
}

func NewCartItemRepo(db *gorm.DB) *CartItemRepo {
	return &CartItemRepo{db: db}
}

func (r *CartItemRepo) AddOrUpdateItem(cartID, productID uint) error {
	var item models.CartItem

	err := r.db.
		Where("cart_id = ? AND product_id = ?", cartID, productID).
		First(&item).Error

	if err == nil {
		item.Quantity++
		return r.db.Save(&item).Error
	}
	if err != gorm.ErrRecordNotFound {
		return err
	}

	newItem := models.CartItem{
		CartID:    cartID,
		ProductID: productID,
		Quantity:  1,
	}

	return r.db.Create(&newItem).Error
}

func (r *CartItemRepo) GetCartItems(cart_id uint) ([]models.CartItem, error) {
	var items []models.CartItem
	err := r.db.Where("cart_id=?", cart_id).Find(&items).Error

	if err != nil {
		return nil, err
	}
	return items, nil
}

func (r *CartItemRepo) DeleteItem(cartID, productID uint) error {
	return r.db.
		Where("cart_id = ? AND product_id = ?", cartID, productID).
		Delete(&models.CartItem{}).
		Error
}

func (r *CartItemRepo) ClearCartItems(cartID uint) error {
	return r.db.
		Where("cart_id = ?", cartID).
		Delete(&models.CartItem{}).
		Error
}

