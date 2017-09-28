class CartItem < ActiveRecord::Base

  ## Associations
  belongs_to :cart, touch: true
  belongs_to :product

  ## Delegates
  delegate :name, :price, to: :product, prefix: true, allow_nil: true

  ## Methods
  def initialize(attributes = {})
    super
    self.quantity = 0
  end

  def total_price
    (self.quantity * self.product_price).to_f
  end

  def self.summary
    Cart.active.joins(cart_items: :product).select("cart_items.product_id, sum(cart_items.quantity) as quantity, sum(cart_items.price * cart_items.quantity) as total, products.name as product_name").group(:product_id)
  end

  def is_price_changed?
    self.price != self.product_price
  end

  def set_quantity(quantity)
    quantity || self.quantity + 1
  end
end
