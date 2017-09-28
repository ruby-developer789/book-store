class Product < ActiveRecord::Base

  ## Associations
  has_many :cart_items
  has_many :order_items
end
