class ProductsController < ApplicationController
  def new
    @product = Product.new
    @product_images = @product.product_images.build
  end
  
  def create
    @shop = Shop.find_by(id: params[:product][:shop_id])
    @product = @shop.products.build(product_params)
    if @product.save
      params[:product_images]['primg'].each do |i|
        @product_image = @product.product_images.create!(:primg => i)
      end
      flash[:success] = "One more product for sale"
      redirect_to @shop
    else
      flash[:danger] = "There is an error. Please try again"
      render 'shops/show', status: :unprocessable_entity
    end
  end
  
  # def index
  #   @products = Shop.find_by(params[:id]).products
  # end

  def show
    @product = Product.find_by(id: params[:id])
    @product_images = @product.product_images.all
  end

  def edit

  end

  def update

  end

  def destroy
    
  end

  private
    def product_params
      params.require(:product).permit(:name, :color, :size, :price, :stock, :description, {primg: []})
    end
end
