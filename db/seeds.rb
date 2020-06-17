require 'csv'

USERS_FILE = Rails.root.join('db', 'seed_data', 'users.csv')
puts "Loading raw driver data from #{USERS_FILE}"

user_failures = []
CSV.foreach(USERS_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  user.email = row['email']
  user.uid = row['uid']
  user.provider = row['provider']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


CATEGORIES_FILE = Rails.root.join('db', 'seed_data', 'categories.csv')
puts "Loading raw driver data from #{CATEGORIES_FILE}"

category_failures = []
CSV.foreach(CATEGORIES_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['name']
  
  successful = category.save
  if !successful
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created category: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categorys failed to save"





ORDERS_FILE = Rails.root.join('db', 'seed_data', 'orders.csv')
puts "Loading raw driver data from #{ORDERS_FILE}"

order_failures = []
CSV.foreach(ORDERS_FILE, :headers => true) do |row|
  order = Order.new
  order.order_status = row['order_status']
  order.email_address = row['email_address']
  order.mailing_address = row['mailing_address']
  order.name_on_credit_card = row['name_on_credit_card']
  order.credit_card_number = row['credit_card_number']
  order.credit_card_expiration = row['credit_card_expiration']
  order.credit_card_CVV = row['credit_card_CVV']
  order.billing_zip_code = row['billing_zip_code']

  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save order: #{order.inspect}"
  else
    puts "Created order: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} orders failed to save"


PRODUCTS_FILE = Rails.root.join('db', 'seed_data', 'products.csv')
puts "Loading new products data from #{PRODUCTS_FILE}"

USERS_NAMES = ["Grace Hopper","Ada Lovelace","Susan Wojcicki","Sheryl Sandberg","Hedy Lamarr","Radia Perlman","Mary Keller","Katherine Johnson","Manal Sharif","Jasmine Anteunis"]

product_failures = []
CSV.foreach(PRODUCTS_FILE, :headers => true) do |row|
  product = Product.new
  product.name = row['name']
  product.price = row['price']
  product.description = row['description']
  product.photo_url = row['photo_url']
  product.stock = row['stock']
  rand_user = USERS_NAMES[rand(0..9)]
  product.user = User.find_by(name: rand_user)
  product.product_status = row['product_status']
  successful = product.save
  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end

puts "Added #{Product.count} products records"
puts "#{product_failures.length} products failed to save"


ORDER_ITEMS_FILE = Rails.root.join('db', 'seed_data', 'order_items.csv')
puts "Loading raw order_item data from #{ORDER_ITEMS_FILE}"

order_item_failures = []
CSV.foreach(ORDER_ITEMS_FILE, :headers => true) do |row|
  order_item = OrderItem.new
  order_item.quantity = row['quantity']
  order_item.order_id = row['order_id']
  order_item.product_id = row['product_id']
  order_item.order_item_status = row['order_item_status']


  successful = order_item.save
  if !successful
    order_item_failures << order_item
    puts "Failed to save order_item: #{order_item.inspect}, errors: #{order_item.errors.messages}"
  else
    puts "Created order_item: #{order_item.inspect}"
  end
end

puts "Added #{OrderItem.count} order_item records"
puts "#{order_item_failures.length} order_items failed to save"




REVIEWS_FILE = Rails.root.join('db', 'seed_data', 'reviews.csv')
puts "Loading raw driver data from #{REVIEWS_FILE}"

review_failures = []
CSV.foreach(REVIEWS_FILE, :headers => true) do |row|
  review = Review.new
  review.rating = row['rating']
  review.text = row['text']
  review.product_id = row['product_id']
  
  successful = review.save
  if !successful
    review_failures << review
    puts "Failed to save review: #{review.inspect}"
  else
    puts "Created review: #{review.inspect}"
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} reviews failed to save"






