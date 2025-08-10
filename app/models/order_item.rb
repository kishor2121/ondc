class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  after_create_commit :broadcast_new_order
  after_update_commit :broadcast_status_change

  def total
    total_cents.to_f / 100
  end

  private

  def broadcast_new_order
    Turbo::StreamsChannel.broadcast_append_to "orders", target: "orders_list", partial: "orders/order", locals: { order: self }
  end

  def broadcast_status_change
    Turbo::StreamsChannel.broadcast_replace_to "order_#{id}", target: "order_#{id}_status", partial: "orders/status", locals: { order: self }
  end
end
