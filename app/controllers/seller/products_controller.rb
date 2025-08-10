module Seller
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_seller

    def new
      @product = current_user.products.build
    end

    def create
      @product = current_user.products.build(product_params)
      if @product.save
        redirect_to root_path, notice: "Product created"
      else
        render :new
      end
    end

    def edit
      @product = current_user.products.find(params[:id])
    end

    def update
      @product = current_user.products.find(params[:id])
      if @product.update(product_params)
        redirect_to root_path, notice: "Updated"
      else
        render :edit
      end
    end

    def destroy
      current_user.products.find(params[:id]).destroy
      redirect_to root_path, notice: "Deleted"
    end

    private

    def ensure_seller
      redirect_to root_path, alert: "Not a seller" unless current_user.seller?
    end

    def product_params
      params.require(:product).permit(:title, :description, :price_cents, :stock)
    end
  end
end
