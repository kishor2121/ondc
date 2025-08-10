module Seller
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_seller

    def index
      # naive: show orders that include seller's products
      @orders = Order.joins(:order_items).where(order_items: { product_id: current_user.products.pluck(:id) }).distinct
    end

    def show
      @order = Order.find(params[:id])
    end

    def update
      @order = Order.find(params[:id])
      @order.update(status: params[:status])
      head :ok
    end

    private

    def ensure_seller
      redirect_to root_path, alert: "Not a seller" unless current_user.seller?
    end
  end
end
