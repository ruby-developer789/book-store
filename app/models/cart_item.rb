class CartItem < ActiveRecord::Base

  ## Associations
  belongs_to :cart, touch: true
  belongs_to :product

  ## Delegates
  delegate :name, :price, to: :product, prefix: true, allow_nil: true

  ## Methods
  def total_price
    (self.quantity * self.price).to_f
  end

  def self.summary
    Cart.active.joins(cart_items: :product).select("cart_items.product_id, sum(cart_items.quantity) as quantity, (cart_items.price * cart_items.quantity) as total, products.name as product_name").group(:product_id)
  end
end
