class ProductsController < ApplicationController

  before_action :expire_cart

  def index
    @products = Product.all
  end
end
