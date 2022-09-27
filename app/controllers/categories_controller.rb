class CategoriesController < ApplicationController
  def index
    @categs = Category.all
  end

  def show
    @categ_items = ProductCategory.where("category_id = ?", params[:id])
  end
end
