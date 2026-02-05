package repo

import (
	"ecommerce_project/internal/models"

	"gorm.io/gorm"
)

type OrderRepo struct{
	db *gorm.DB
}

func NewOrderRepo(db *gorm.DB)*OrderRepo{
	return &OrderRepo{db:db}
}

func(r *OrderRepo)CreateOrder(order *models.Order)error{
	return r.db.Create(order).Error
}
func (r *OrderRepo) CreateOrderItems(items []models.OrderItem) error {
	return r.db.Create(&items).Error
}
func (r *OrderRepo) GetOrdersByUserID(userID uint) ([]models.Order, error) {
	var orders []models.Order

	err := r.db.
		Where("user_id = ?", userID).
		Preload("OrderItems").
		Find(&orders).Error

	if err != nil {
		return nil, err
	}

	return orders, nil
}
func (r *OrderRepo) GetAllOrders() ([]models.Order, error) {
	var orders []models.Order

	err := r.db.
		Preload("OrderItems").
		Find(&orders).Error

	if err != nil {
		return nil, err
	}

	return orders, nil
}
func (r *OrderRepo) GetOrderByID(orderID uint) (*models.Order, error) {
	var order models.Order

	err := r.db.
		Where("id = ?", orderID).
		Preload("OrderItems").
		First(&order).Error

	if err != nil {
		return nil, err
	}

	return &order, nil
}
func (r *OrderRepo) UpdateOrderStatus(orderID uint, status string) error {
	result:= r.db.
		Model(&models.Order{}).
		Where("id = ?", orderID).
		Update("status", status)
		
	if result.Error!=nil{
		return result.Error
	}	
	if result.RowsAffected==0{
		return gorm.ErrRecordNotFound
	}
	return nil
}

func (r *OrderRepo) UpdateRazorpayOrderID(orderID uint, razorpayOrderID string) error {
	return r.db.
		Model(&models.Order{}).
		Where("id = ?", orderID).
		Update("razorpay_order_id", razorpayOrderID).
		Error
}

func (r *OrderRepo) UpdatePaymentSuccess(orderID uint, paymentID string) error {
	return r.db.Model(&models.Order{}).
		Where("id = ?", orderID).
		Updates(map[string]interface{}{
			"razorpay_payment_id": paymentID,
			"payment_status":      "paid",
			"status":              "paid",
		}).Error
}





