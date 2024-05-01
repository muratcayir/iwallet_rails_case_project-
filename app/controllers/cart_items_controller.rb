class CartItemsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_cart_item, only: [:show, :update, :destroy]

  # GET /cart_items
  def index
    @cart_items = CartItem.all
    render json: @cart_items
  end

  # GET /cart_items/:id
  def show
    render json: @cart_item
  end

  # POST /cart_items
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.calculate_subtotal  # Calculate subtotal
    if @cart_item.save
      render json: @cart_item, status: :created
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_items/:id
  def update
    if @cart_item.update(cart_item_params)
      @cart_item.calculate_subtotal  
      render json: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end


  # DELETE /cart_items/:id
  def destroy
    @cart_item.destroy
    update_cart_subtotal
    render json: { message: 'Cart item was successfully destroyed' }, status: :ok
  end

  private

  # Set the cart item before performing actions
  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through
  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :book_id, :quantity, :subtotal)
  end
end