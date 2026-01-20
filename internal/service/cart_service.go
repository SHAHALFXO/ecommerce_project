package service
import(
		"ecommerce_project/internal/repo"
			"ecommerce_project/internal/models"


)
type CartService struct {
	cartRepo     *repo.CartRepo
	cartItemRepo *repo.CartItemRepo
}

func NewCartService(cr *repo.CartRepo, cir *repo.CartItemRepo) *CartService {
	return &CartService{
		cartRepo:     cr,
		cartItemRepo: cir,
	}
}

func (s *CartService) AddToCart(userID, productID uint) error {
	
	cart, err := s.cartRepo.GetOrCreateCart(userID)
	if err != nil {
		return err
	}

	return s.cartItemRepo.AddOrUpdateItem(cart.ID, productID)
}

func (s *CartService) GetCart(userID uint) (*models.Cart, []models.CartItem, error) {
	cart, err := s.cartRepo.GetOrCreateCart(userID)
	if err != nil {
		return nil, nil, err
	}

	items, err := s.cartItemRepo.GetCartItems(cart.ID)
	if err != nil {
		return nil, nil, err
	}

	return cart, items, nil
}
func (s *CartService) RemoveItem(userID, productID uint) error {
	cart, err := s.cartRepo.GetOrCreateCart(userID)
	if err != nil {
		return err
	}

	return s.cartItemRepo.DeleteItem(cart.ID, productID)
}

func (s *CartService) ClearCart(userID uint) error {
	cart, err := s.cartRepo.GetOrCreateCart(userID)
	if err != nil {
		return err
	}

	return s.cartItemRepo.ClearCartItems(cart.ID)
}
