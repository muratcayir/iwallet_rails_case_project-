class CartsController < ApplicationController
  include ActionController::MimeResponds
  before_action :authenticate_request!
  before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    @carts = Cart.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/:id
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      render json: @cart, status: :created
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/:id
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/:id
  def destroy
    @cart.destroy
    render json: { message: 'Cart was successfully destroyed' }, status: :ok
  end

  private

  # Set the cart before performing actions
  def set_cart
    @cart = Cart.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through
  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
