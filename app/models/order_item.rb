class OrderItem < ActiveRecord::Base

  ##Associations
  belongs_to :order
  belongs_to :product

  ## Methods
  def total_price
    (self.quantity * self.price).to_f
  end
end
