class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.where("title ILIKE ?", "%#{params[:query]}%").order(:id)
    else
      @products = Product.all.order(:id)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
