package repo

import (
	"ecommerce_project/internal/models"

	"gorm.io/gorm"
)

type ProductRepo struct {
	db *gorm.DB
}

func NewProductRepo(db *gorm.DB) *ProductRepo {
	return &ProductRepo{db: db}
}

func (r *ProductRepo) CreateProduct(product *models.Product) error {
	return r.db.Create(product).Error
}

func (r *ProductRepo) GetProductByID(id uint) (*models.Product, error) {
	var product models.Product
	err := r.db.First(&product, id).Error
	if err != nil {
		return nil, err
	}
	return &product, nil
}

func (r *ProductRepo) GetAllProducts() ([]models.Product, error) {
	var products []models.Product
	err := r.db.Find(&products).Error
	if err != nil {
		return nil, err
	}
	return products, nil
}

func (r *ProductRepo) UpdateProduct(p *models.Product) error {
	return r.db.Model(&models.Product{}).Where("id=?", p.ID).Updates(p).Error
}

func (r *ProductRepo)DeleteProduct(id uint)error{
	return r.db.Delete(&models.Product{},id).Error
}
