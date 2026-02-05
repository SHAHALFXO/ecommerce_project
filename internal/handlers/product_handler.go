package handlers

import (
	"ecommerce_project/internal/models"
	"ecommerce_project/internal/service"
	
	"net/http"
	"strconv"


	"github.com/gin-gonic/gin"
)

type ProductHandler struct {
	service *service.ProductService
}

func NewProductHandler(s *service.ProductService) *ProductHandler {
	return &ProductHandler{service: s}
}

func (h *ProductHandler) List(c *gin.Context) {
	products, err := h.service.ListProducts()
	if err != nil {
		c.JSON(500, gin.H{"error": "server error"})
		return
	}
	c.JSON(200, products)

}

func (h *ProductHandler) Get(c *gin.Context) {
	idparam, err := strconv.Atoi(c.Param("id"))

	if err != nil || idparam <= 0 {
		c.JSON(400, gin.H{"error": "invalid id"})
		return
	}
	id := uint(idparam)
	product, err := h.service.GetProductByID(id)
	if err != nil {
		c.JSON(500, gin.H{"error": "product not found"})
		return
	}
	c.JSON(200, product)

}

type ProductDetails struct {
	Name        string  `gorm:"not null" json:"name"`
	Price       float64 `gorm:"not null" json:"price"`
	Stock       int     `gorm:"not null" json:"stock"`
	Description string  `json:"description"`
	Category    string  `json:"category"`
	ImageURL    string  `json:"image_url"`
}

func (h *ProductHandler) Create(c *gin.Context) {

	var body ProductDetails

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}

	if body.Name == "" || body.Price <= 0 || body.Stock < 0 || body.Category == "" {
		c.JSON(400, gin.H{"error": "Product details required"})
		return
	}

	product := models.Product{
		Name:        body.Name,
		Price:       body.Price,
		Stock:       body.Stock,
		Description: body.Description,
		Category:    body.Category,
		ImageURL:    body.ImageURL,
	}

	err := h.service.CreateProduct(&product)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "internal error"})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"msg": "product created","product":product})

}
func (h *ProductHandler) Delete(c *gin.Context) {
	idStr := c.Param("id")

	idInt, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid id"})
		return
	}

	id := uint(idInt)

	err = h.service.DeleteProduct(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "internal error"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"msg": "product deleted successfully"})
}

func (h *ProductHandler) Update(c *gin.Context) {

	idparam, err := strconv.Atoi(c.Param("id"))
	if err != nil || idparam <= 0 {
		c.JSON(400, gin.H{"error": "invalid id"})
		return
	}

	var body models.Product

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(400, gin.H{"error": "invalid body"})
		return
	}

	body.ID = uint(idparam)

	err = h.service.UpdateProduct(&body)
	if err != nil {
		c.JSON(400, gin.H{"error": err.Error()})
		return
	}

	c.JSON(200, gin.H{"message": "updated"})
}
