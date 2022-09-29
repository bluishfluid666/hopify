class ProductsController < ApplicationController
  before_action :logged_in_user
  before_action :has_shop?, only: [:new, :create]
  before_action :is_product_owner?, only: [:edit, :update, :destroy]
  def new
    @product = Product.new
    @product_images = @product.product_images.build
    @product_stocks = @product.product_stocks.build
    @categs = Category.all
  end
  
  def create
    # binding.pry
    params[:product][:category_ids] = params[:product][:category_ids].reject { |pc| pc == "" }
    @shop = Shop.find_by(id: params[:product][:shop_id])
    @product = @shop.products.build(product_params)
    prod_stcks_hash = params[:product][:product_stocks_attributes]
    # binding.pry
    if @product.save
      primg_array = params[:product_images][:primg].reject { |pi| pi == "" }
      primg_array.each do |i|
        @product_image = @product.product_images.create!(:primg => i)
      end
      prod_stcks_hash.each do |k, v|
        v.permit!
        @product_stock = @product.product_stocks.create!(v)
      end
      # binding.pry
      flash[:success] = "One more product for sale"
      redirect_to @shop
    else
      flash[:danger] = "There is an error. Please try again"
      redirect_to add_product_url, status: :unprocessable_entity
    end
    # debugger
  end
  
  # def index
  #   @products = 
  # end
  
  def show
    @product = Product.find_by(id: params[:id])
    @product_stocks = @product.product_stocks.all
    @product_images = @product.product_images.all
    # @color_2_size_ids = {}
    # current_stocks = @product.product_stocks
    # @color_arr = current_stocks.map{ |ps| ps.color }.uniq
    #=> color_arr = {"Dark Iris", "Brown"}
    # @color_arr.each do |c|
    #   @color_2_size_ids[c] = current_stocks.where("color = ?", c).map{|s| s.apparel_size_id}
    # end
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
    
  end

  def change_price
    
  end
  
  def edit
    @product = Product.find_by(id: params[:id])
    @product_images = @product.product_images.all
  end
  
  def update
    # debugger
    # binding.pry
    @product = Product.find(params[:id])
    delete_these_img_ids = params[:del_img] if params[:del_img]
    append_these_imgs = params[:prod_img] if params[:prod_img]
    delete_these_stocks = params[:del_ps] if params[:del_ps]
    prod_stcks_hash = params[:product][:product_stocks_attributes]
    # binding.pry
    if @product.update(product_params)
      if delete_these_img_ids
        delete_these_img_ids.each do |id|
          @product.product_images.find(id).destroy
        end
      end
      if append_these_imgs
        append_these_imgs.each do |img|
          @product.product_images.create(primg: img)
        end
      end
      
      if delete_these_stocks
        delete_these_stocks.each do |ps|
          @product.product_stocks.find(ps).destroy
        end
      end
      
      prod_stcks_hash.each do |k, v|
        v.permit!
        @product_stock = @product.product_stocks.update(v)
      end
      
      flash[:success] = "Shop and Products updated"
      redirect_to edit_shop_url(@product.shop_id)
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "Product #{@product.name}: deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end
  
  def newCartSession
    if current_user.cart_session.nil?
      @cart_session = CartSession.new
      @cart_session[:user_id] = current_user.id
      @cart_session.save
    end
  end
  def get_product
    # binding.pry
    # debugger
    newCartSession
    @cart_item = current_user.cart_session.cart_items.find_by(product_stock_id: params[:product_stock])
    if @cart_item
      @cart_item.increment(:quantity, params[:product_quantity].to_i)
    else
      @cart_item = ProductStock.find(params[:product_stock]).cart_items.build
      @cart_item.cart_session_id = current_user.cart_session.id
      @cart_item.quantity = params[:product_quantity]
    end
    if @cart_item.save
      flash.now[:success] = "Added to cart"
    end
    respond_to do |format|
      # format.html{ redirect_to product_path(params[:id])}
      format.html
      format.js
    end
  end
  
  private
    def product_params
      params.require(:product).permit(:name, :description, category_ids:[], product_images_attributes:[:id, :product_id, :primg], product_stocks_attributes:[:id, :product_id, :apparel_size_id, :color, :stock, :price])
    end
end
