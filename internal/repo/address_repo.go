package repo

import (
	"ecommerce_project/internal/models"
	"gorm.io/gorm"
)

type AddressRepo struct {
	db *gorm.DB
}

func NewAddressRepo(db *gorm.DB) *AddressRepo {
	return &AddressRepo{db: db}
}

func (r *AddressRepo) CreateAddress(address *models.UserAddress) error {
	return r.db.Create(address).Error
}

func (r *AddressRepo) GetUserAddresses(userID uint) ([]models.UserAddress, error) {
	var addresses []models.UserAddress
	err := r.db.Where("user_id = ?", userID).Find(&addresses).Error
	return addresses, err
}

func (r *AddressRepo) UpdateAddress(userID, addressID uint, addr models.UserAddress) error {
	return r.db.
		Model(&models.UserAddress{}).
		Where("id = ? AND user_id = ?", addressID, userID).
		Updates(addr).
		Error
}