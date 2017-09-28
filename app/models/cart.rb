class Cart < ActiveRecord::Base

  ##Scopes
  scope :active, -> { where("carts.updated_at > ? ", 2.days.ago) }

  ## Associations
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  ## Methods

  def add_cart_item(product_id, quantity)
    cart_item = self.cart_items.where(product_id: product_id).first_or_initialize
    cart_item.quantity = cart_item.set_quantity(quantity)
    cart_item.price = cart_item.product_price
    cart_item.save
    cart_item
  end

  def is_expired?
    self.updated_at < 2.days.ago
  end
end
