Product.create!(name: "Banana", price: 0.49, active: true)
Product.create!(name: "Apple", price: 0.29, active: true)
Product.create!(name: "Carton of Strawberries", price: 1.99, active: true)

puts "3 products created"

OrderStatus.create!(name: "In Progress")
OrderStatus.create!(name: "Placed")
OrderStatus.create!(name: "Shipped")
OrderStatus.create!(name: "Cancelled")

puts "4 OrderStatuses created"
