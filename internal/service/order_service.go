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
	ProductRepo  *repo.ProductRepo
}

func NewOrderService(or *repo.OrderRepo, cr *repo.CartRepo, cir *repo.CartItemRepo, pr *repo.ProductRepo) *OrderService {
	return &OrderService{OrderRepo: or, CartRepo: cr, CartItemRepo: cir, ProductRepo: pr}
}

func(s *OrderService) PlaceOrder(UserId uint) (*models.Order, error) {

	cart, err := s.CartRepo.GetOrCreateCart(UserId)

	if err != nil {
		return nil, err
	}

	items, err := s.CartItemRepo.GetCartItems(cart.ID)
	if err != nil {
		return nil, err
	}

	if len(items) == 0 {
		return nil, errors.New("cart is empty")
	}
	var total float64
	var orderItems []models.OrderItem
	for _, item := range items {

		product, err := s.ProductRepo.GetProductByID(item.ProductID)
		if err != nil {
			return nil, err
		}

		price := product.Price

		total += price * float64(item.Quantity)

		orderItems = append(orderItems, models.OrderItem{
			ProductID: item.ProductID,
			Quantity:  uint(item.Quantity),
			Price:     price,
		})

	}
	order := models.Order{
		UserID: UserId,
		Status: "pending",
		Total:  total,
	}

	if err := s.OrderRepo.CreateOrder(&order); err != nil {
		return nil, err
	}

	for i := range orderItems {
		orderItems[i].OrderID = order.ID
	}

	if err := s.OrderRepo.CreateOrderItems(orderItems); err != nil {
		return nil, err
	}

	if err := s.CartItemRepo.ClearCartItems(cart.ID); err != nil {
		return nil, err
	}
	return &order, nil

}

func (s *OrderService) GetMyOrders(UserID uint) ([]models.Order, error) {

	Orders, err := s.OrderRepo.GetOrdersByUserID(UserID)
	if err != nil {
		return nil, err
	}
	return Orders, nil
}

func (s *OrderService) GetOrderDetails(UserID,OrderID uint,role string) (*models.Order, error) {
	order, err := s.OrderRepo.GetOrderByID(OrderID)
     if err != nil {
		return nil, err
	}

	if order.UserID!=UserID && role!="admin"{
		return nil,errors.New("forbidden")
	}
	
	return order, nil
}

func (s *OrderService) GetAllOrders() ([]models.Order, error) {
	orders, err := s.OrderRepo.GetAllOrders()
	if err != nil {
		return nil, err
	}
	return orders, nil
}

func (s *OrderService) UpdateOrderStatus(orderID uint, status string) error {

	return s.OrderRepo.UpdateOrderStatus(orderID, status)
}
