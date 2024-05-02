class CartItemsController < ApplicationController
  include ActionController::MimeResponds
  before_action :authenticate_request!
  before_action :set_cart_item, only: [:show, :update, :destroy]

  # GET /cart_items
  def index
    @cart_items = CartItem.all
    respond_to do |format|
      format.json { render json: @cart_items }
      format.html # index.html.erb
    end
  end

  # GET /cart_items/:id
  def show
    respond_to do |format|
      format.json { render json: @cart_item }
      format.html # show.html.erb
    end
  end

  # POST /cart_items
  def create
    @cart_item = CartItem.new(cart_item_params)
    respond_to do |format|
      if @cart_item.save
        format.json { render json: @cart_item, status: :created, location: @cart_item }
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
      else
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cart_items/:id
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { render json: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/:id
  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.' }
      format.json { render json: { message: 'Cart item was successfully destroyed' }, status: :ok }
    end
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
