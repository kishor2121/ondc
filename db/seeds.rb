User.create!(email: "buyer@example.com", password: "password", password_confirmation: "password", seller: false)
seller = User.create!(email: "seller@example.com", password: "password", password_confirmation: "password", seller: true)

products = [
  { title: "T-shirt", description: "Nice tee", price_cents: 2000, stock: 20 },
  { title: "Sneakers", description: "Comfortable", price_cents: 5000, stock: 10 },
  { title: "Headphones", description: "Noise canceling", price_cents: 3000, stock: 5 }
]

products.each do |p|
  seller.products.create!(p)
end
