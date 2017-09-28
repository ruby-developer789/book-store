class OrdersController < ApplicationController
  before_action :expire_cart

  def index
    @orders = current_user.orders
  end

  def confirm_order
    @order = current_user.orders.build
    @order.confirm_order
    respond_to do |format|
      format.html{ redirect_to root_path, notice: 'Thanks!!! Order has been placed successfully.'}
    end
  end
end
