class CartItemsController < ApplicationController
  before_action :expire_cart

  def index
    @cart_items = current_user.cart_items
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    respond_to do |format|
      format.js
    end
  end
end
