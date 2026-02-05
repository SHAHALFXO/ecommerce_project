package handlers

import (
	"net/http"
	"strconv"

	"ecommerce_project/internal/service"
	"github.com/gin-gonic/gin"
)

type CartHandler struct {
	cartService *service.CartService
}

func NewCartHandler(cs *service.CartService) *CartHandler {
	return &CartHandler{cartService: cs}
}

func (h *CartHandler) AddToCart(c *gin.Context) {
	userID := c.MustGet("user_id").(uint) 

	productIDStr := c.Query("product_id")
	productIDInt, err := strconv.Atoi(productIDStr)
	if err != nil || productIDInt <= 0 {
		c.JSON(400, gin.H{"error": "invalid product_id"})
		return
	}

	productID := uint(productIDInt)

	err = h.cartService.AddToCart(userID, productID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "item added to cart"})
}

func (h *CartHandler) GetCart(c *gin.Context) {
	userID := c.MustGet("user_id").(uint)

	cart, items, err := h.cartService.GetCart(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"cart":  cart,
		"items": items,
	})
}

func (h *CartHandler) RemoveItem(c *gin.Context) {
	userID := c.MustGet("user_id").(uint)

	productIDStr := c.Param("product_id")
	productIDInt, err := strconv.Atoi(productIDStr)
	if err != nil || productIDInt <= 0 {
		c.JSON(400, gin.H{"error": "invalid product_id"})
		return
	}

	productID := uint(productIDInt)

	err = h.cartService.RemoveItem(userID, productID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "item removed"})
}
func (h *CartHandler) ClearCart(c *gin.Context) {
	userID := c.MustGet("user_id").(uint)

	err := h.cartService.ClearCart(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "cart cleared"})
}
