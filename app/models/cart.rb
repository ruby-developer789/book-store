class Cart < ActiveRecord::Base

  ##Scopes
  scope :active, -> { where("carts.updated_at > ? ", 2.days.ago) }

  ## Associations
  has_many :cart_items, dependent: :destroy

  ## Methods
  def add_cart_item(product_id, quantity)
    product = Product.find(product_id)
    cart_item = self.cart_items.where(product_id: product_id).try(:first) || self.cart_items.build(product_id: product_id)
    cart_item.quantity = quantity.presence || (cart_item.quantity.to_i + 1)
    cart_item.price = product.price
    cart_item.save
    cart_item
  end

  def is_expired?
    self.updated_at < 2.days.ago
  end
end
