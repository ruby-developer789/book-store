class CartsController < ApplicationController
	before_action :expire_cart

  def add_to_cart
    @cart = current_user.cart || current_user.create_cart
    @cart_item = @cart.add_cart_items(params[:product_id], params[:quantity])
  end

  def show
  	@cart_items = current_user.cart_items
  end
end
