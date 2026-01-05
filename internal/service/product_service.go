package service

import (
	"ecommerce_project/internal/models"
	"ecommerce_project/internal/repo"
	"errors"
)

type ProductService struct {
	productRepo *repo.ProductRepo
}

func NewProductService(productRepo *repo.ProductRepo) *ProductService {
	return &ProductService{productRepo: productRepo}
}

func (s *ProductService) ListProducts() ([]models.Product, error) {
	products, err := s.productRepo.GetAllProducts()
	if err != nil {
		return nil, err
	}
	return products, nil

}

func (s *ProductService) GetProductByID(id uint) (*models.Product, error) {
	if id == 0 {
		return nil, errors.New("invalid product id")
	}

	product, err := s.productRepo.GetProductByID(id)
	if err != nil {
		return nil, err
	}

	return product, nil
}

func (s *ProductService) CreateProduct(p *models.Product) error {
	if p.Name == "" {
		return errors.New("product name is required")
	}

	if p.Price <= 0 {
		return errors.New("price must be greater than zero")
	}

	if p.Stock < 0 {
		return errors.New("stock cannot be negative")
	}

	return s.productRepo.CreateProduct(p)
}
func (s *ProductService) UpdateProduct(p *models.Product) error {
	if p.ID == 0 {
		return errors.New("invalid product id")

	}
	if p.Name == "" || p.Price <= 0 || p.Stock < 0 {
		return errors.New("invalid product details")

	}
	return s.productRepo.UpdateProduct(p)
}

func (s *ProductService) DeleteProduct(id uint) error {

	if id == 0 {
		return errors.New("invalid id")
	}
	return s.productRepo.DeleteProduct(id)

}
