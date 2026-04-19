puts "Seeding provinces..."
Province.destroy_all

provinces_data = [
  { name: "Alberta",                   gst: 5.0, pst: 0.0,   hst: 0.0  },
  { name: "British Columbia",          gst: 5.0, pst: 7.0,   hst: 0.0  },
  { name: "Manitoba",                  gst: 5.0, pst: 7.0,   hst: 0.0  },
  { name: "New Brunswick",             gst: 0.0, pst: 0.0,   hst: 15.0 },
  { name: "Newfoundland and Labrador", gst: 0.0, pst: 0.0,   hst: 15.0 },
  { name: "Northwest Territories",     gst: 5.0, pst: 0.0,   hst: 0.0  },
  { name: "Nova Scotia",               gst: 0.0, pst: 0.0,   hst: 15.0 },
  { name: "Nunavut",                   gst: 5.0, pst: 0.0,   hst: 0.0  },
  { name: "Ontario",                   gst: 0.0, pst: 0.0,   hst: 13.0 },
  { name: "Prince Edward Island",      gst: 0.0, pst: 0.0,   hst: 15.0 },
  { name: "Quebec",                    gst: 5.0, pst: 9.975, hst: 0.0  },
  { name: "Saskatchewan",              gst: 5.0, pst: 6.0,   hst: 0.0  },
  { name: "Yukon",                     gst: 5.0, pst: 0.0,   hst: 0.0  }
]

provinces_data.each do |p|
  Province.find_or_create_by!(name: p[:name]) do |province|
    province.gst = p[:gst]
    province.pst = p[:pst]
    province.hst = p[:hst]
  end
end
puts "Created #{Province.count} provinces"

# Categories
puts "Seeding categories..."
categories = {}
[ "Electronics", "Accessories", "Laptops", "Networking" ].each do |name|
  categories[name] = Category.find_or_create_by!(name: name)
end
puts "Created #{Category.count} categories"

# Products with images
puts "Seeding products..."

images_path = Rails.root.join("db/seeds/images")

products_data = [
  { name: "Digital Camera Z50",        description: "24MP mirrorless camera with 4K video and Wi-Fi.",              price: 899.99,  stock: 10, category: "Electronics",  image: "Digital Camera.jpg" },
  { name: "Portable SSD 1TB",          description: "USB-C portable SSD with 1050MB/s read speeds.",                price: 119.99,  stock: 35, category: "Electronics",  image: "Portable SSD.jpg" },
  { name: "Smart TV 55 inch",          description: "4K Ultra HD Smart TV with HDR and streaming apps.",            price: 699.99,  stock: 15, category: "Electronics",  image: "Digital Camera.jpg" },
  { name: "Bluetooth Speaker Pro",     description: "Portable waterproof speaker with 360 sound.",                  price: 89.99,   stock: 30, category: "Electronics",  image: "Portable SSD.jpg" },
  { name: "Wireless Headphones X1",   description: "Noise cancelling headphones with 30hr playback.",              price: 149.99,  stock: 25, category: "Electronics",  image: "Digital Camera.jpg" },
  { name: "Smartwatch Series 5",       description: "Health tracking smartwatch with GPS and heart rate monitor.",  price: 299.99,  stock: 20, category: "Electronics",  image: "Portable SSD.jpg" },
  { name: "Tablet Pro 11",             description: "11-inch tablet with 2K display and 128GB storage.",            price: 499.99,  stock: 18, category: "Electronics",  image: "Digital Camera.jpg" },
  { name: "E-Reader Paperwhite",       description: "Waterproof e-reader with adjustable warm light.",              price: 139.99,  stock: 22, category: "Electronics",  image: "Portable SSD.jpg" },
  { name: "Webcam 4K Pro",             description: "4K streaming webcam with auto-focus and ring light.",          price: 129.99,  stock: 28, category: "Electronics",  image: "Digital Camera.jpg" },
  { name: "Power Bank 26800mAh",       description: "High capacity power bank with fast charging.",                 price: 59.99,   stock: 40, category: "Electronics",  image: "Portable SSD.jpg" },

  { name: "Gaming Laptop RTX 4070",    description: "15.6 inch gaming laptop with RTX 4070 and 16GB RAM.",          price: 1799.99, stock: 8,  category: "Laptops",      image: "Tributo-Platinum-v2.jpg" },
  { name: "Ultrabook Slim 14",         description: "Ultra-thin 14 inch laptop with Intel i5 and 512GB SSD.",       price: 999.99,  stock: 12, category: "Laptops",      image: "Ultrabook.jpg" },
  { name: "Budget Laptop",             description: "Affordable laptop perfect for everyday computing tasks.",       price: 349.99,  stock: 20, category: "Laptops",      image: "Budget laptop.jpg" },
  { name: "MacBook Alternative",       description: "Premium thin and light laptop with all-day battery life.",     price: 1299.99, stock: 9,  category: "Laptops",      image: "IMG_9060.jpeg" },
  { name: "Student Chromebook",        description: "Lightweight Chromebook perfect for students.",                  price: 299.99,  stock: 15, category: "Laptops",      image: "Apple-MacBook-Air-M2-1662464544-0-0.jpg" },
  { name: "2-in-1 Convertible Laptop", description: "360 degree convertible laptop with touchscreen support.",      price: 849.99,  stock: 10, category: "Laptops",      image: "Ultrabook.jpg" },
  { name: "Business Laptop Pro",       description: "Enterprise grade laptop with fingerprint reader.",              price: 1199.99, stock: 8,  category: "Laptops",      image: "Budget laptop.jpg" },
  { name: "Workstation Laptop",        description: "High performance laptop for professional creative work.",       price: 2199.99, stock: 5,  category: "Laptops",      image: "Tributo-Platinum-v2.jpg" },
  { name: "Thin Light Laptop",         description: "Incredibly thin laptop weighing just 1.1kg.",                  price: 1099.99, stock: 12, category: "Laptops",      image: "Apple-MacBook-Air-M2-1662464544-0-0.jpg" },
  { name: "Gaming Laptop Pro",         description: "High refresh rate display gaming laptop with RGB keyboard.",   price: 1599.99, stock: 7,  category: "Laptops",      image: "IMG_9060.jpeg" },

  { name: "Gaming Mouse 16000 DPI",    description: "Precision gaming mouse with programmable buttons.",            price: 69.99,   stock: 30, category: "Accessories",  image: "Gaming Mouse.jpg" },
  { name: "Mouse Pad XL",             description: "Extra large mouse pad with non-slip rubber base.",             price: 24.99,   stock: 45, category: "Accessories",  image: "Mouse Pad.jpg" },
  { name: "Laptop Bag 15.6 inch",     description: "Water resistant laptop bag with USB charging port.",           price: 49.99,   stock: 35, category: "Accessories",  image: "Laptop Bag.jpg" },
  { name: "Mechanical Keyboard TKL",  description: "Tenkeyless mechanical keyboard with RGB backlight.",           price: 129.99,  stock: 25, category: "Accessories",  image: "Gaming Mouse.jpg" },
  { name: "USB-C Hub 7-in-1",         description: "Multiport USB-C hub with HDMI and 100W power delivery.",      price: 49.99,   stock: 40, category: "Accessories",  image: "Mouse Pad.jpg" },
  { name: "Wireless Charger Pad",     description: "15W fast wireless charging pad for all Qi devices.",           price: 29.99,   stock: 50, category: "Accessories",  image: "Laptop Bag.jpg" },
  { name: "Phone Stand Adjustable",   description: "Aluminum adjustable phone and tablet stand.",                  price: 19.99,   stock: 60, category: "Accessories",  image: "Gaming Mouse.jpg" },
  { name: "Cable Organizer Kit",      description: "Reusable velcro cable ties and organizer clips.",              price: 14.99,   stock: 70, category: "Accessories",  image: "Mouse Pad.jpg" },
  { name: "Screen Protector Pro",     description: "Tempered glass screen protector with 9H hardness.",            price: 12.99,   stock: 80, category: "Accessories",  image: "Laptop Bag.jpg" },
  { name: "Laptop Stand Aluminum",    description: "Ergonomic aluminum laptop stand with adjustable height.",      price: 39.99,   stock: 35, category: "Accessories",  image: "Gaming Mouse.jpg" },

  { name: "WiFi 6 Router AX3000",     description: "Dual band WiFi 6 router covering up to 2500 sq ft.",          price: 179.99,  stock: 15, category: "Networking",   image: "VPN router.jpg" },
  { name: "WiFi Range Extender",      description: "Dual band WiFi extender with ethernet port and WPS.",          price: 49.99,   stock: 25, category: "Networking",   image: "Wifi extender.jpg" },
  { name: "Network Switch 8-Port",    description: "Unmanaged 8-port gigabit ethernet switch.",                    price: 39.99,   stock: 20, category: "Networking",   image: "VPN router.jpg" },
  { name: "Mesh WiFi System",         description: "3-pack mesh WiFi system covering up to 5500 sq ft.",           price: 299.99,  stock: 10, category: "Networking",   image: "Wifi extender.jpg" },
  { name: "VPN Router Pro",           description: "Pre-configured VPN router with privacy protection.",           price: 199.99,  stock: 12, category: "Networking",   image: "VPN router.jpg" },
  { name: "Modem Router Combo",       description: "DOCSIS 3.1 modem router for Canadian ISPs.",                   price: 219.99,  stock: 8,  category: "Networking",   image: "Wifi extender.jpg" },
  { name: "Powerline Adapter Kit",    description: "1000Mbps powerline adapter kit with ethernet ports.",          price: 79.99,   stock: 18, category: "Networking",   image: "VPN router.jpg" },
  { name: "Network Attached Storage", description: "2-bay NAS for home media server and backup.",                  price: 349.99,  stock: 7,  category: "Networking",   image: "Wifi extender.jpg" },
  { name: "WiFi 6E Router",           description: "Tri-band WiFi 6E router with 6GHz band support.",              price: 399.99,  stock: 6,  category: "Networking",   image: "VPN router.jpg" },
  { name: "Ethernet Cable 10-Pack",   description: "Cat6 ethernet cables in various lengths, 10-pack.",            price: 29.99,   stock: 40, category: "Networking",   image: "Wifi extender.jpg" }
]

products_data.each do |p|
  product = Product.find_or_create_by!(name: p[:name]) do |prod|
    prod.description    = p[:description]
    prod.price          = p[:price]
    prod.stock_quantity = p[:stock]
    prod.category       = categories[p[:category]]
  end

  # Attach image if not already attached
  if !product.image.attached?
    image_file = images_path.join(p[:image])
    if File.exist?(image_file)
      product.image.attach(
        io: File.open(image_file),
        filename: p[:image],
        content_type: "image/jpeg"
      )
      print "."
    else
      puts "Image not found: #{p[:image]}"
    end
  end
end

puts "\nCreated #{Product.count} products with images"

# Admin user
puts "Creating admin user..."
User.find_or_create_by!(email: "admin@prairietech.com") do |u|
  u.password              = "password123"
  u.password_confirmation = "password123"
  u.first_name            = "Admin"
  u.last_name             = "User"
  u.role                  = "admin"
end

# Pages
puts "Creating pages..."
Page.find_or_create_by!(slug: "about") do |p|
  p.title   = "About Us"
  p.content = "Welcome to Prairie Tech Store. We are a Canadian electronics retailer."
end

Page.find_or_create_by!(slug: "contact") do |p|
  p.title   = "Contact Us"
  p.content = "Email us at support@prairietech.com or call 1-800-PRAIRIE."
end

puts "Done!"
puts "Categories: #{Category.count}"
puts "Products:   #{Product.count}"
puts "Users:      #{User.count}"
puts "Pages:      #{Page.count}"
