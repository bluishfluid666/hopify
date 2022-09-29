class StaticPagesController < ApplicationController
  def home
    @products = Product.order(created_at: :desc).limit(25).page(params[:page])
  end

  def help
  end

  def blog
  end

  def contact
  end
end
