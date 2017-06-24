class RootController < ApplicationController
  def index
    @products = Product.where(is_available: true)
    # gon.products = Product.where(is_available: true)
  end
end
