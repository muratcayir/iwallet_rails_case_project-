class PaymentsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_user_cart, only: [:process_payment]

  def process_payment
 
    cart_total_price = @user_cart.total_price
    
    payment_success = simulate_payment(cart_total_price)
    
    if payment_success
      @user_cart.cart_items.destroy_all
      render json: { message: 'Payment successful' }, status: :ok
    else
      render json: { error: 'Payment failed' }, status: :unprocessable_entity
    end
  end

  private

  def set_user_cart
    @user_cart = current_user.cart
  end

  def simulate_payment(total_price)
    true
  end
end
