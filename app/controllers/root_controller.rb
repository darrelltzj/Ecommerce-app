class RootController < ApplicationController
  def index
    @products = Product.where(status: 'available')
    # gon.products = Product.where(status: 'available')
  end
end
