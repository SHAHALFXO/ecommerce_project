package service

import (
	"crypto/hmac"
	"crypto/sha256"
	"ecommerce_project/internal/repo"
	"encoding/hex"
	"os"
	"strconv"
	"errors"

	"github.com/razorpay/razorpay-go"
)

type PaymentService struct {
	orderRepo *repo.OrderRepo
	client    *razorpay.Client
	keyID     string
}

func NewPaymentService(orderRepo *repo.OrderRepo) *PaymentService {
	keyID := os.Getenv("RAZORPAY_KEY_ID")
	keySecret := os.Getenv("RAZORPAY_KEY_SECRET")

	client := razorpay.NewClient(keyID, keySecret)
	return &PaymentService{
		orderRepo: orderRepo,
		client:    client,
		keyID:     keyID,
	}
}

func (s *PaymentService) CreateRazorPayOrder(orderID uint) (string, int, string, error) {
	order, err := s.orderRepo.GetOrderByID(orderID)

	if err != nil {
		return "", 0, "", err
	}
	amount := int(order.Total * 100)
	data := map[string]interface{}{
		"amount":   amount,
		"currency": "INR",
		"receipt":  strconv.Itoa(int(order.ID)),
	}
	res, err := s.client.Order.Create(data, nil)

	if err != nil {
		return "", 0, "", err
	}
	razorpayOrderID := res["id"].(string)

	err = s.orderRepo.UpdateRazorpayOrderID(orderID, razorpayOrderID)
	if err != nil {
		return "", 0, "", err
	}
	return razorpayOrderID, amount, s.keyID, nil

}

func (s *PaymentService) VerifyRazorpayPayment(orderID uint, razorpayOrderID, razorpayPaymentID, razorpaySignature string) error {
	secret := os.Getenv("RAZORPAY_KEY_SECRET")

	data := razorpayOrderID + "|" + razorpayPaymentID

	h := hmac.New(sha256.New, []byte(secret))
	h.Write([]byte(data))
	expectedSignature := hex.EncodeToString(h.Sum(nil))

	if expectedSignature != razorpaySignature {
		return errors.New("invalid payment signature")
	}

	
	return s.orderRepo.UpdatePaymentSuccess(orderID, razorpayPaymentID)
}


