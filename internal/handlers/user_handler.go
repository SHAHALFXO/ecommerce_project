package handlers

import (
	"ecommerce_project/internal/repo"
	"net/http"

	"github.com/gin-gonic/gin"
)

type UserHandler struct {
	repo *repo.UserRepo
}

func NewUserHandler(r *repo.UserRepo) *UserHandler {
	return &UserHandler{repo: r}
}

func (h *UserHandler) Profile(c *gin.Context) {
	uid, ok := c.Get("user_id")

	if !ok {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "user id missing"})
		return
	}
	UserID:=uid.(uint)
	user,err:=h.repo.GetUserByID(UserID)

	if err!=nil{
		c.JSON(http.StatusNotFound,gin.H{"error":"user not found"})
		return
	}
	c.JSON(http.StatusOK,gin.H{"User":user})

}
