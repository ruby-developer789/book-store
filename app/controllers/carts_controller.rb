class CartsController < ApplicationController
  before_action :expire_cart

  def add_to_cart
    @cart = current_user.cart || current_user.create_cart
    @cart_item = @cart.add_cart_item(params[:product_id], params[:quantity])
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Added to cart."}
    end
  end

  def show
    @cart_items = current_user.cart_items
  end
end
