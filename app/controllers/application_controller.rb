# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :search
  include SessionsHelper

  def search
    # binding.pry
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in!'
      redirect_to root_url, status: :see_other
    end
  end

  def is_owner?
    if logged_in?
      shop = Shop.find(params[:id])
      unless current_user.id == shop.user_id
        flash[:danger] = 'You do not have permission for this action'
        redirect_to shop, status: :see_other
      end
    else
      flash[:danger] = 'You do not have permission for this action'
      redirect_to root_url, status: :see_other
    end
  end

  def has_shop?
    logged_in_user # answer for: what if the user doesnt log in and still types in the url to the products#new
    unless current_user.shops.any?
      flash[:danger] = "You can't perform this action because we can't find your shop."
      redirect_to shops_url, status: :see_other
    end
  end

  def is_product_owner?
    logged_in_user
    product = Product.find(params[:id])
    shop = Shop.find(product.shop_id)
    unless shop.user_id == current_user.id
      flash[:danger] = 'You are not authorized for this action.'
      redirect_to root_url, status: :see_other
    end
  end
end
