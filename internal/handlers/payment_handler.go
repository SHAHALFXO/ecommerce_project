package handlers

import (
	"net/http"
	"strconv"

	"ecommerce_project/internal/service"
	"github.com/gin-gonic/gin"
)

type PaymentHandler struct {
	paymentService *service.PaymentService
}

func NewPaymentHandler(ps *service.PaymentService) *PaymentHandler {
	return &PaymentHandler{paymentService: ps}
}

func (h *PaymentHandler) CreateRazorpayOrder(c *gin.Context) {
	orderIDStr := c.Param("order_id")
	orderIDInt, err := strconv.Atoi(orderIDStr)
	if err != nil || orderIDInt <= 0 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid order_id"})
		return
	}

	razorpayOrderID, amount, keyID, err := h.paymentService.CreateRazorPayOrder(uint(orderIDInt))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"key_id":            keyID,
		"razorpay_order_id": razorpayOrderID,
		"amount":            amount,
		"currency":          "INR",
	})
}

func (h *PaymentHandler) VerifyRazorpayPayment(c *gin.Context) {
	var req struct {
		OrderID           uint   `json:"order_id"`
		RazorpayOrderID   string `json:"razorpay_order_id"`
		RazorpayPaymentID string `json:"razorpay_payment_id"`
		RazorpaySignature string `json:"razorpay_signature"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}

	err := h.paymentService.VerifyRazorpayPayment(
		req.OrderID,
		req.RazorpayOrderID,
		req.RazorpayPaymentID,
		req.RazorpaySignature,
	)

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "payment verified successfully"})
}
