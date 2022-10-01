# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :logged_in_user
  def index
    if current_cart
      @cart_items = current_cart.cart_items.page(params[:page])
      @order = Order.new
    else
      @cart_items = []
    end
  end

  def create
    # debugger
    exceeded = false
    newCartSession
    @cart_item = current_cart.cart_items.find_by(product_stock_id: params[:cart_item][:product_stock])
    if @cart_item
      c = @cart_item.increment(:quantity, params[:product_quantity].to_i).quantity
      exceeded = true if c > @cart_item.product_stock.stock
    elsif params[:product_quantity].to_i > ProductStock.find(params[:cart_item][:product_stock]).stock
      exceeded = true
    else
      @cart_item = ProductStock.find(params[:cart_item][:product_stock]).cart_items.build
      @cart_item.cart_session_id = current_cart.id
      @cart_item.shop_id = params[:shop_id]
      @cart_item.quantity = params[:product_quantity]
    end
    if exceeded
      flash[:danger] = 'Your demand quantity exceeds our stock.'
      redirect_to product_path(params[:product_id]), status: :unprocessable_entity
      # don't render because the information for @product will be lost
    else
      @cart_item.save
      current_cart.save
      flash[:success] = 'Added to cart'
      redirect_to @cart_item.product_stock.product
    end
    # respond_to do |format|
    #   # format.html{ redirect_to product_path(params[:id])}
    #   format.html
    #   format.turbo_stream
    # end
  end

  def update
    # debugger
    exceeded = false
    @cart_items = current_cart.cart_items
    @cart_item = @cart_items.find(params[:id])
    exceeded = true if params[:cart_item][:quantity].to_i > @cart_item.product_stock.stock
    if exceeded
      flash[:danger] = 'Your demand quantity exceeds our stock.'
      render 'index', status: :unprocessable_entity
    else
      @cart_item.update(cart_item_params)
      current_cart.save!
      redirect_to cart_items_path
    end
  end

  def destroy
    # debugger
    current_cart_session = current_cart
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    current_cart_session.save!
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
