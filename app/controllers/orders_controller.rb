class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    cart = current_user.cart
    return redirect_to cart_path, alert: "Cart empty" if cart.cart_items.empty?

    order = current_user.orders.create!(status: "placed", total_cents: cart.cart_items.sum { |i| i.subtotal_cents })
    cart.cart_items.each do |ci|
      order.order_items.create!(product: ci.product, quantity: ci.quantity, price_cents: ci.product.price_cents)
    end
    cart.cart_items.destroy_all

    respond_to do |format|
      format.html { redirect_to order_path(order), notice: "Order placed" }
      format.turbo_stream { render turbo_stream: turbo_stream.append("orders_list", partial: "orders/order", locals: { order: order }) }
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  # simple status update (for demo) - sellers will use seller namespace
  def update
    @order = Order.find(params[:id])
    authorize! # placeholder: ensure only allowed users can update
    @order.update(status: params[:status])
    head :ok
  end
end
