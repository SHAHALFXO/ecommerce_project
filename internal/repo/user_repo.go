package repo

import (
    "gorm.io/gorm"
    
    "ecommerce_project/internal/models"
)


type UserRepo struct {
    db *gorm.DB
}


func NewUserRepo(db *gorm.DB) *UserRepo {
    return &UserRepo{db: db}
}

func (r *UserRepo) CreateUser(user *models.User) error {
    return r.db.Create(user).Error
}

func (r *UserRepo) GetUserByEmail(email string) (*models.User, error) {
    var user models.User
    err := r.db.Where("email = ?", email).First(&user).Error
    if err != nil {
        return nil, err
    }
    return &user, nil
}

func (r *UserRepo) GetUserByID(id uint) (*models.User, error) {
    var user models.User
    err := r.db.First(&user, id).Error
    if err != nil {
        return nil, err
    }
    return &user, nil
}
