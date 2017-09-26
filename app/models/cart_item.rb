class CartItem < ActiveRecord::Base
  belongs_to :cart, touch: true
  belongs_to :product

  ## Delegates
  delegate :id, :name, :price, to: :product, prefix: true, allow_nil: true

  ## Methods
  def total_price
    (self.quantity * self.price).to_f
  end
end
