package handlers

import (
	"net/http"
	"strconv"

	"ecommerce_project/internal/models"
	"ecommerce_project/internal/service"

	"github.com/gin-gonic/gin"
)

type AddressHandler struct {
	service *service.AddressService
}

func NewAddressHandler(s *service.AddressService) *AddressHandler {
	return &AddressHandler{service: s}
}

func (h *AddressHandler) AddAddress(c *gin.Context) {
	userID := c.MustGet("user_id").(uint)

	var addr models.UserAddress
	if err := c.ShouldBindJSON(&addr); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid input"})
		return
	}

	if err := h.service.AddAddress(userID, addr); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "address added"})
}

func (h *AddressHandler) GetMyAddresses(c *gin.Context) {
	userID := c.MustGet("user_id").(uint)

	addresses, err := h.service.GetMyAddresses(userID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"addresses": addresses})
}
func (h *AddressHandler) EditAddress(c *gin.Context) {

	userID := c.MustGet("user_id").(uint)

	addressIDStr := c.Param("address_id")
	addressIDInt, err := strconv.Atoi(addressIDStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid address id"})
		return
	}

	var addr models.UserAddress
	if err := c.ShouldBindJSON(&addr); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid input"})
		return
	}

	err = h.service.EditAddress(userID, uint(addressIDInt), addr)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "address updated"})
}