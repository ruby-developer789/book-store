class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def expire_cart
    if current_user && current_user.cart.try(:is_expired?)
      current_user.cart.destroy
      redirect_to root_path, notice: "Your cart has been expired"
    end
  end
end
