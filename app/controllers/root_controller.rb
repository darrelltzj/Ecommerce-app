class RootController < ApplicationController
  def index
    @products = Product.where(is_available: true)
    gon.products = Product.all()
  end
end
