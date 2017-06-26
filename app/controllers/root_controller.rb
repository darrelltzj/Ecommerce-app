class RootController < ApplicationController
  def index
    @products = Product.where(status: 'available')
  end
end
