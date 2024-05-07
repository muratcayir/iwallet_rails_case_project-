class CartItemsController < ApplicationController
    before_action :authorize_request
    before_action :set_cart
    before_action :set_cart_item, only: [:update, :destroy]
  
    # Sepete yeni bir kitap ekleme
    def create
      book = Book.find(params[:book_id])
      quantity = params[:quantity].to_i
  
      if @cart.add_book(book, quantity)
        render json: { message: 'Kitap sepete eklendi.', cart: @cart }, status: :created
      else
        render json: { message: 'Kitap eklenemedi.' }, status: :unprocessable_entity
      end
    end
  
    # Sepet öğesinin miktarını güncelleme
    def update
      quantity = params[:quantity].to_i
  
      if quantity > 0
        @cart_item.update(quantity: quantity)
        render json: { message: 'Sepet güncellendi.', cart: @cart }, status: :ok
      else
        @cart_item.destroy
        render json: { message: 'Kitap sepetten çıkarıldı.', cart: @cart }, status: :ok
      end
    end
  
    # Sepetten belirli bir kitabı çıkarma
    def destroy
      @cart_item.destroy
      render json: { message: 'Kitap sepetten çıkarıldı.', cart: @cart }, status: :ok
    end
  
    private
  
    # Kullanıcının sepetini ayarlayan yardımcı metod
    def set_cart
      @cart = current_user.cart || current_user.create_cart
    end
  
    # İlgili sepet öğesini ayarlayan yardımcı metod
    def set_cart_item
      @cart_item = @cart.cart_items.find(params[:id])
    end
  end
  