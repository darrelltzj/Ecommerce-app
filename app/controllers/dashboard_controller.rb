class DashboardController < ApplicationController
  before_action :is_authenticated
  def index
    @products = Product.where(user: current_user)
    @products_available = @products.where(status: 'available')
    @products_unavailable = @products.where(status: 'unavailable')
    @product = Product.new
    @orders = Order.where(user: current_user)
    if params[:store]
      @store = params[:store]
    end
  end
end
