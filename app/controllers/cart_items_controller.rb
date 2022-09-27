class CartItemsController < ApplicationController
  def index
    if current_user.cart_session
      @cart_items = current_user.cart_session.cart_items
      @order = Order.new
    else
      @cart_items = []
    end
  end
  def create
    # debugger
    newCartSession
    @cart_item = current_user.cart_session.cart_items.find_by(product_stock_id: params[:cart_item][:product_stock])
    if @cart_item
      @cart_item.increment(:quantity, params[:product_quantity].to_i)
    else
      @cart_item = ProductStock.find(params[:cart_item][:product_stock]).cart_items.build
      @cart_item.cart_session_id = current_user.cart_session.id
      @cart_item.shop_id = params[:shop_id]
      @cart_item.quantity = params[:product_quantity]
    end
    if @cart_item.save && current_user.cart_session.save
      flash[:success] = "Added to cart"
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
    current_cart_session = current_user.cart_session
    @cart_items = current_cart_session.cart_items 
    @cart_item = @cart_items.find(params[:id])
    if @cart_item.update(cart_item_params) && current_cart_session.save!
      redirect_to cart_items_path
    end
  end
  
  def destroy
    # debugger
    current_cart_session = current_user.cart_session
    @cart_item = current_user.cart_session.cart_items.find(params[:id])
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
