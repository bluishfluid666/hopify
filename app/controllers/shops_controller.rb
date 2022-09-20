class ShopsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create]
  before_action :is_owner?, only: [:edit, :update, :destroy]
  def new
    @shop = current_user.shops.build
  end
  
  def create
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      flash[:success] = "Let's go on another trade!"
      redirect_to @shop
    else
      render 'shops/new', status: :unprocessable_entity
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @products = @shop.products.all
    # debugger
  end

  def index
    @shops = current_user.shops.all
  end

  def edit
    # binding.pry
    @shop = current_user.shops.find_by(id: params[:id])
    @products = @shop.products.all
  end

  def update
    @shop = current_user.shops.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = "Updated shop successfully!"
      redirect_to @shop
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    shop = current_user.shops.find(params[:id])
    shop.destroy
    flash[:success] = "#{shop.name} deleted"
    redirect_to shops_url, status: :see_other
  end
  
  private
    def shop_params
      params.require(:shop).permit(:name, :description, :phone, :address, :homesite, :shop_avatar)
    end
end
