package service

import (
	"ecommerce_project/internal/models"
	"ecommerce_project/internal/repo"
)

type AddressService struct {
	repo *repo.AddressRepo
}

func NewAddressService(r *repo.AddressRepo) *AddressService {
	return &AddressService{repo: r}
}

func (s *AddressService) AddAddress(userID uint, addr models.UserAddress) error {
	addr.UserID = userID
	return s.repo.CreateAddress(&addr)
}

func (s *AddressService) GetMyAddresses(userID uint) ([]models.UserAddress, error) {
	return s.repo.GetUserAddresses(userID)
}

func (s *AddressService) EditAddress(userID, addressID uint, addr models.UserAddress) error {
	return s.repo.UpdateAddress(userID, addressID, addr)
}