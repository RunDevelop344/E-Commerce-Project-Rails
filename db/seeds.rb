require 'httparty'
require 'nokogiri'
require 'faker'
require 'open-uri'

puts "Cleaning old data..."
Product.destroy_all
Category.destroy_all

# -----------------------------------------------
# REQUIREMENT 1.8 — API: FakeStoreAPI
# -----------------------------------------------
puts "Fetching products from FakeStoreAPI..."

category_map = {
  "electronics" => "Electronics",
  "jewelery"    => "Accessories"
}

categories = {}
["Electronics", "Accessories", "Laptops", "Networking"].each do |name|
  categories[name] = Category.find_or_create_by!(name: name)
end

response = HTTParty.get("https://fakestoreapi.com/products")
api_products = JSON.parse(response.body)

api_count = 0
api_products.each do |item|
  next unless ["electronics", "jewelery"].include?(item["category"])
  category_name = category_map[item["category"]]

  product = Product.find_or_create_by!(name: item["title"]) do |p|
    p.description    = item["description"]
    p.price          = item["price"]
    p.stock_quantity = rand(5..50)
    p.category       = categories[category_name]
  end

  # Auto-attach image from API URL
  if !product.image.attached? && item["image"].present?
    begin
      image_url = item["image"]
      filename = File.basename(URI.parse(image_url).path)
      downloaded_image = URI.open(image_url)
      product.image.attach(
        io: downloaded_image,
        filename: filename,
        content_type: "image/jpeg"
      )
      print "."
    rescue => e
      puts "Could not attach image for #{item["title"]}: #{e.message}"
    end
  end

  api_count += 1
end
puts "\nFetched #{api_count} electronics products from API with images"

# -----------------------------------------------
# REQUIREMENT 1.7 — Web Scraping
# -----------------------------------------------
puts "Scraping products from web..."

scrape_url = "http://books.toscrape.com/catalogue/category/books/science_22/index.html"
page = Nokogiri::HTML(HTTParty.get(scrape_url).body)

scraped_count = 0
page.css("article.product_pod").each do |book|
  title = "Tech Guide: " + book.css("h3 a").attr("title")&.value.to_s
  price_text = book.css("p.price_color").text.gsub(/[^0-9.]/, "")
  price = price_text.to_f

  next if title.blank? || price == 0

  Product.find_or_create_by!(name: title) do |p|
    p.description    = Faker::Lorem.paragraph(sentence_count: 2)
    p.price          = Faker::Commerce.price(range: 19.99..299.99)
    p.stock_quantity = rand(5..30)
    p.category       = categories["Electronics"]
  end
  scraped_count += 1
end
puts "Scraped #{scraped_count} products from web"

# -----------------------------------------------
# REQUIREMENT 1.6 — Faker: Electronics products
# -----------------------------------------------
puts "Generating electronics products with Faker..."

electronics_products = [
  { category: "Electronics", names: ["Smart TV", "Bluetooth Speaker", "Wireless Headphones",
    "Gaming Console", "Digital Camera", "Smartwatch", "Tablet", "E-Reader",
    "Portable SSD", "USB-C Hub", "Webcam", "Mechanical Keyboard", "Gaming Mouse",
    "Monitor Stand", "LED Desk Lamp", "Smart Bulb", "Power Bank", "Car Charger"] },
  { category: "Laptops", names: ["Gaming Laptop", "Ultrabook", "2-in-1 Laptop",
    "Chromebook", "Business Laptop", "Student Laptop", "Workstation Laptop",
    "Budget Laptop", "MacBook Alternative", "Thin & Light Laptop"] },
  { category: "Accessories", names: ["Phone Case", "Screen Protector", "Laptop Bag",
    "Cable Organizer", "Wireless Charger", "Earbuds", "Phone Stand",
    "Laptop Stand", "Mouse Pad", "Cable Clips"] },
  { category: "Networking", names: ["WiFi Router", "Network Switch", "Ethernet Cable",
    "WiFi Extender", "Mesh Network System", "Powerline Adapter",
    "Network Attached Storage", "Modem Router Combo", "WiFi 6 Router", "VPN Router"] }
]

current_count = Product.count
needed = [0, 100 - current_count].max

needed.times do |i|
  group = electronics_products[i % electronics_products.length]
  base_name = group[:names][i % group[:names].length]
  unique_name = "#{base_name} #{Faker::Alphanumeric.alpha(number: 4).upcase}"

  Product.find_or_create_by!(name: unique_name) do |p|
    p.description    = "#{base_name} - #{Faker::Lorem.sentence(word_count: 10)}"
    p.price          = Faker::Commerce.price(range: 9.99..1999.99)
    p.stock_quantity = rand(1..100)
    p.category       = categories[group[:category]]
  end
end
puts "Generated Faker products. Total now: #{Product.count}"

# -----------------------------------------------
# Admin user
# -----------------------------------------------
puts "Creating admin user..."
User.find_or_create_by!(email: "admin@prairietech.com") do |u|
  u.password              = "password123"
  u.password_confirmation = "password123"
end

puts "Done!"
puts "Categories: #{Category.count}"
puts "Products:   #{Product.count}"
puts "Users:      #{User.count}"