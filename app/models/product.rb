class Product < ApplicationRecord
  belongs_to :seller, class_name: "User"
  validates :title, :price_cents, presence: true

  has_one_attached :image

  def price
    price_cents.to_f / 100
  end
end
