class OrdersController < ApplicationController
  before_action :expire_cart

  def index
    @orders = current_user.orders
  end

  def confirm
    @order = current_user.orders.build
    @order.confirm
    respond_to do |format|
      format.html
    end
  end
end
