class ProductsController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :expire_cart

  def index
    @products = Product.all
  end
end
