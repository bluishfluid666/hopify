# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @products = Product.where(published: true).order(created_at: :desc).includes(:product_images).limit(25).page(params[:page])
  end

  def help; end

  def blog; end

  def contact; end
end
