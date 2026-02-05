package main

import (
	"ecommerce_project/internal/db"
	"ecommerce_project/internal/handlers"
	"ecommerce_project/internal/middleware"
	"ecommerce_project/internal/models"
	"ecommerce_project/internal/repo"
	"ecommerce_project/internal/service"
	"fmt"
	"github.com/gin-contrib/cors"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()

	if err != nil {
		fmt.Println("env file not found")
	}

	db.Connection()
	db.DB.AutoMigrate(&models.User{})
	db.DB.AutoMigrate(&models.Product{})
	db.DB.AutoMigrate(&models.Cart{}, &models.CartItem{})
	db.DB.AutoMigrate(&models.Order{}, &models.OrderItem{})

	userRepo := repo.NewUserRepo(db.DB)
	authSvc := service.NewAuthService(userRepo)
	authHandler := handlers.NewAuthHandler(authSvc)
	userHandler := handlers.NewUserHandler(userRepo)

	productRepo := repo.NewProductRepo(db.DB)
	productsvc := service.NewProductService(productRepo)
	productHandler := handlers.NewProductHandler(productsvc)

	cartRepo := repo.NewCartRepo(db.DB)
	cartItemRepo := repo.NewCartItemRepo(db.DB)

	cartSvc := service.NewCartService(cartRepo, cartItemRepo)
	cartHandler := handlers.NewCartHandler(cartSvc)

	orderRepo := repo.NewOrderRepo(db.DB)
	ordersvc := service.NewOrderService(orderRepo, cartRepo, cartItemRepo, productRepo)
	orderHandler := handlers.NewOrderHandler(ordersvc)

	paymentService := service.NewPaymentService(orderRepo)
	paymentHandler := handlers.NewPaymentHandler(paymentService)

	r := gin.Default()

	config := cors.Config{
		AllowOrigins:     []string{"http://localhost:5500", "http://127.0.0.1:5500", "https://yourdomain.com"}, // add real domain later
		AllowMethods:     []string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}

	r.Use(cors.New(config))

	r.POST("/auth/signup", authHandler.Signup)
	r.POST("/auth/login", authHandler.Login)

	r.GET("/products", productHandler.List)
	r.GET("/products/:id", productHandler.Get)

	r.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})

	authGroup := r.Group("/me")
	authGroup.Use(middleware.AuthMiddleware())
	authGroup.GET("/profile", userHandler.Profile)

	adminGroup := r.Group("/admin")
	adminGroup.Use(middleware.AuthMiddleware(), middleware.AdminOnly())
	adminGroup.GET("/products", func(c *gin.Context) {
		c.JSON(200, gin.H{"msg": "admin products route ok"})
	})

	adminGroup.POST("/products", productHandler.Create)
	adminGroup.DELETE("/products", productHandler.Delete)

	cart := r.Group("/cart")
	cart.Use(middleware.AuthMiddleware())

	cart.POST("/add", cartHandler.AddToCart)
	cart.GET("", cartHandler.GetCart)
	cart.DELETE("/item/:product_id", cartHandler.RemoveItem)
	cart.DELETE("/clear", cartHandler.ClearCart)

	adminGroup.GET("/orders", orderHandler.GetAllOrders)
	adminGroup.PATCH("/update/:order_id/:status", orderHandler.UpdateOrderStatus)

	order := r.Group("/orders")
	order.Use(middleware.AuthMiddleware())
	order.POST("/place", orderHandler.PlaceOrder)
	order.GET("/", orderHandler.GetMyOrders)
	order.GET("/details/:order_id", orderHandler.GetOrderDetails)

	payment := r.Group("/payments")
	payment.Use(middleware.AuthMiddleware())

	payment.POST("/razorpay/order/:order_id", paymentHandler.CreateRazorpayOrder)
	payment.POST("/razorpay/verify", paymentHandler.VerifyRazorpayPayment)


	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Println("Listening on :" + port)
	r.Run(":" + port)

}
