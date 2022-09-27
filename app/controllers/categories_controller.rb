class CategoriesController < ApplicationController
  def index
    @categs = Category.all
  end

  def show
    @categ_items = ProductCategory.where("category_id = ?", params[:id]).order(created_at: :desc).page(params[:page])
  end
end
