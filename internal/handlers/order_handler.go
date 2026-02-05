package handlers

import (
	"ecommerce_project/internal/service"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type OrderHandler struct {
	orderService *service.OrderService
}

func NewOrderHandler(orderService *service.OrderService) *OrderHandler {
	return &OrderHandler{orderService: orderService}
}

func (h *OrderHandler) PlaceOrder(c *gin.Context) {

	userID := c.MustGet("user_id").(uint)

	order, err := h.orderService.PlaceOrder(userID)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Order placed succesfully", "order": order})

}
func (h *OrderHandler) GetMyOrders(c *gin.Context) {
	userID := c.MustGet("user_id").(uint)

	orders, err := h.orderService.GetMyOrders(userID)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"orders": orders})
}

func (h *OrderHandler) GetOrderDetails(c *gin.Context) {
	orderIdstr := c.Param("order_id")
	orderIDint, err := strconv.Atoi(orderIdstr)

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	orderID := uint(orderIDint)
	userID := c.MustGet("user_id").(uint)
	role := c.MustGet("user_role").(string)
	order, err := h.orderService.GetOrderDetails(userID, orderID, role)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"order": order})

}

func (h *OrderHandler) GetAllOrders(c *gin.Context) {
	orders, err := h.orderService.GetAllOrders()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"orders": orders})

}
func (h *OrderHandler) UpdateOrderStatus(c *gin.Context) {
	orderIdstr := c.Param("order_id")
	orderIDint, err := strconv.Atoi(orderIdstr)

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	orderID := uint(orderIDint)
	status := c.Param("status")
	err = h.orderService.UpdateOrderStatus(orderID, status)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "order status updated"})

}
