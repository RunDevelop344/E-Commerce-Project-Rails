categories = Category.create!([
  { name: "Laptops" },
  { name: "Smartphones" },
  { name: "Accessories" },
  { name: "Monitors" },
  { name: "Networking" }
])

# --- Products ---
Product.create!([
  { name: "MacBook Pro 16-inch", description: "Apple M2 chip, 16GB RAM, 1TB SSD", price: 2499.99, stock_quantity: 10, category: categories[0] },
  { name: "Dell XPS 13", description: "Intel i7, 16GB RAM, 512GB SSD, sleek ultrabook", price: 1499.99, stock_quantity: 15, category: categories[0] },
  { name: "iPhone 15 Pro", description: "Latest Apple iPhone with A17 chip and 128GB storage", price: 1199.99, stock_quantity: 25, category: categories[1] },
  { name: "Samsung Galaxy S24", description: "Samsung flagship smartphone with 256GB storage", price: 1099.99, stock_quantity: 20, category: categories[1] },
  { name: "Logitech MX Master 3", description: "Advanced wireless mouse for productivity", price: 99.99, stock_quantity: 50, category: categories[2] },
  { name: "Anker PowerCore 20000", description: "High-capacity portable charger for devices", price: 49.99, stock_quantity: 40, category: categories[2] },
  { name: "LG UltraGear 27-inch", description: "Gaming monitor with 144Hz refresh rate", price: 399.99, stock_quantity: 12, category: categories[3] },
  { name: "Dell UltraSharp 24-inch", description: "Professional monitor with accurate colors", price: 299.99, stock_quantity: 18, category: categories[3] },
  { name: "TP-Link AC1750 Router", description: "High-speed dual-band Wi-Fi router", price: 89.99, stock_quantity: 30, category: categories[4] },
  { name: "Netgear Nighthawk Switch", description: "Gigabit network switch for home or office", price: 129.99, stock_quantity: 10, category: categories[4] }
])

# --- Users (for testing orders) ---
user = User.first || User.create!(email: "testuser@example.com", password: "password123", password_confirmation: "password123")

# --- Orders ---
10.times do |i|
  order = Order.create!(
    user_id: user.id,           # link to test user
    total: rand(50..3000).round(2)  # use 'total' instead of 'total_price'
  )
  puts "Created Order ##{order.id} with total $#{order.total}"
end