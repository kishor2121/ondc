# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    cart = current_user.cart

    cart_item = cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity ||= 0
    cart_item.quantity += 1

    if cart_item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to products_path, notice: "Added to cart" }
      end
    else
      redirect_to products_path, alert: "Could not add to cart"
    end
  end

  def update
    cart_item = current_user.cart.cart_items.find(params[:id])
    if cart_item.update(quantity: params[:quantity])
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cart_path }
      end
    end
  end

  def destroy
    cart_item = current_user.cart.cart_items.find(params[:id])
    cart_item.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path, notice: "Item removed" }
    end
  end
end
