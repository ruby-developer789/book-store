class CartItemsController < ApplicationController
  before_action :expire_cart
  skip_before_action :authenticate_user!, only: [:summary]

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

  def summary
    @cart_items = CartItem.summary
  end
end
