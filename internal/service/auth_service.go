package service


import (
    "errors"
    "os"
    "time"

    "golang.org/x/crypto/bcrypt"
    "github.com/golang-jwt/jwt/v5"

    "ecommerce_project/internal/models"
    "ecommerce_project/internal/repo"
)

type AuthService struct {
    userRepo *repo.UserRepo
}

func NewAuthService(userRepo *repo.UserRepo) *AuthService {
    return &AuthService{userRepo: userRepo}
}


func (s *AuthService) Register(email, password string) error {
    hashed, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
    if err != nil {
        return err
    }

    user := models.User{
        Email:        email,
        PasswordHash: string(hashed),
        Role:         "customer",
    }

    return s.userRepo.CreateUser(&user)
}

func (s *AuthService) Login(email, password string) (string, error) {
    user, err := s.userRepo.GetUserByEmail(email)
    if err != nil {
        return "", errors.New("user not found")
    }

    err = bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(password))
    if err != nil {
        return "", errors.New("invalid password")
    }

    token, err := s.generateJWT(user)
    if err != nil {
        return "", err
    }

    return token, nil
}

func (s *AuthService) generateJWT(user *models.User) (string, error) {
    secret := os.Getenv("JWT_SECRET")
    if secret == "" {
        secret = "secret123" 
    }

    claims := jwt.MapClaims{
        "sub":  user.ID,
        "email": user.Email,
        "role": user.Role,
        "exp":  time.Now().Add(15 * time.Minute).Unix(),
    }

    token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
    return token.SignedString([]byte(secret))
}
