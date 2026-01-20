package service

import (
	"ecommerce_project/internal/models"
	"ecommerce_project/internal/repo"
	"errors"

)

type OrderService struct {
	OrderRepo    *repo.OrderRepo
	CartRepo     *repo.CartRepo
	CartItemRepo *repo.CartItemRepo
}

func NewOrderService(or *repo.OrderRepo, cr *repo.CartRepo, cir *repo.CartItemRepo) *OrderService {
	return &OrderService{OrderRepo: or, CartRepo: cr, CartItemRepo: cir}
}

func (s *OrderService) PlaceOrder(UserId uint) (*models.Order, error) {
	cart, err := s.CartRepo.GetOrCreateCart(UserId)

	if err != nil {
		return nil, err
	}

	items, err := s.CartItemRepo.GetCartItems(cart.ID)
	if err != nil {
		return nil, err
	}

	if len(items)==0{
		return nil,errors.New("cart is empty")
	}


}
