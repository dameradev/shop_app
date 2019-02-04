class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  #overides the filed subtotal
  #order.subtotal calls the function
  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  private

  # when order is created to change status
  def set_order_status
    self.order_status_id = 1
  end

  #when order is saved to update the subtotal
  #sums up total cost
  def update_subtotal
    #this is how we update the field subtotal
    self[:subtotal] = subtotal
  end

end
