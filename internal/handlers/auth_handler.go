package handlers

import (
	"ecommerce_project/internal/db"
	"ecommerce_project/internal/models"
	"ecommerce_project/internal/service"
	"ecommerce_project/internal/utils"
	"log"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type AuthHandler struct {
	authService *service.AuthService
}

func NewAuthHandler(authService *service.AuthService) *AuthHandler {
	return &AuthHandler{authService: authService}
}

type SignupRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}
type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (h *AuthHandler) Signup(c *gin.Context) {

	var body SignupRequest

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}
	if body.Email == "" || body.Password == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "email and password required"})
		return
	}

	err := h.authService.Register(body.Email, body.Password)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"msg": "user created suCCesfully"})

}

func (h *AuthHandler) Login(c *gin.Context) {
	var body LoginRequest

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid credentials"})
		return
	}

	if body.Email == "" || body.Password == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "email and password required"})
		return
	}

	token, err := h.authService.Login(body.Email, body.Password)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"token": token})
}

func (h *AuthHandler) ForgotPassword(c *gin.Context) {

	var body struct {
		Email string `json:"email"`
	}

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(400, gin.H{"error": "invalid request"})
		return
	}

	var user models.User
	err := db.DB.Where("email = ?", body.Email).First(&user).Error

	if err == nil {
		token := uuid.NewString()
		expiry := time.Now().Add(15 * time.Minute)

		db.DB.Model(&user).Updates(map[string]interface{}{
			"reset_token": token,
			"reset_token_expiry": expiry,
		})

		resetLink := "http://localhost:8080/frontend/reset-password.html?token=" + token

		err=utils.SendResetEmail(user.Email, resetLink)
		if err!=nil{
			log.Println("error sending email",err)
		}else{
			log.Println("email sent succesfully")
		}


	}

	c.JSON(200, gin.H{"msg": "if email exists, reset link sent"})
}

func (h *AuthHandler) ResetPassword(c *gin.Context) {

	var body struct {
		Token       string `json:"token"`
		NewPassword string `json:"new_password"`
	}

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(400, gin.H{"error": "invalid request"})
		return
	}

	var user models.User
	err := db.DB.Where("reset_token = ?", body.Token).First(&user).Error

	if err != nil || time.Now().After(*user.ResetTokenExpiry) {
		c.JSON(400, gin.H{"error": "invalid or expired token"})
		return
	}

	hashed, _ := bcrypt.GenerateFromPassword(
		[]byte(body.NewPassword),
		bcrypt.DefaultCost,
	)

	db.DB.Model(&user).Updates(map[string]interface{}{
		"password_hash": hashed,
		"reset_token": "",
		"reset_token_expiry": nil,
	})

	c.JSON(200, gin.H{"msg": "password updated successfully"})
}


