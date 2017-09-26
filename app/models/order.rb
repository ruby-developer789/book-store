class Order < ActiveRecord::Base
  ## Associations
  belongs_to :user
  has_many :order_items, dependent: :destroy

  ## Methods
  def confirm_order
    self.user.cart_items.each do |cart_item|
      order_item = self.order_items.build(quantity: cart_item.quantity, price: cart_item.product_price, product_id: cart_item.product_id)
    end
    self.save
    self.user.cart.destroy
  end

  def total_price
    self.order_items.map(&:total_price).inject(:+).to_f
  end
end
