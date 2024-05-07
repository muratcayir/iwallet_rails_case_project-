class CartsController < ApplicationController
    before_action :authorize_request
    before_action :set_cart, only: [:show, :checkout, :clear]
  
    # Sepetin detaylarının görüntülenmesi
    def show
      render json: @cart.as_json(include: { cart_items: { include: :book } })
    end
  
    # Ödeme işleminin gerçekleştirilmesi
    def checkout
      if @cart.checkout
        render json: { message: 'Ödeme başarılı. Siparişiniz alındı.' }, status: :ok
      else
        render json: { message: 'Ödeme işlemi başarısız.' }, status: :unprocessable_entity
      end
    end
  
    # Sepetin tamamen temizlenmesi
    def clear
      @cart.clear
      render json: { message: 'Sepet temizlendi.' }, status: :ok
    end
  
    private
  
    # Kullanıcının sepetini ayarlayan yardımcı metod
    def set_cart
      @cart = current_user.cart || current_user.create_cart
    end
  end
  