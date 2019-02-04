class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  #ensures that we have more than 0 product(s)
  validates :quantity, presence:true, numericality: { only_integer: true, greater_than: 0 }
  #custom validations
  validate :product_present
  validate :order_present

  before_save :finalize

  #if the order_item doesn't yet exist we take the assosiated product's unit_price
  #elseif the order_item does exist the contents of the unit price will be returned instad
  # This means that once the product is added to our cart, if the product changes price the user will still be able to buy the product at the previous price.
  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private
  def product_present
    if product.nil?
      errors.add(:product, "is not vaild or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order")
    end
  end

  #updates the unit and total price with the proper values
  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]

  end
end
