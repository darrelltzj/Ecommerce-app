class OrdersController < ApplicationController
  include Format
  before_action :is_authenticated
  helper OrdersHelper

  # def index
    # @orders = Order.where(user: current_user)
  # end

  # def new
  # end

  def create
    @product = Product.find(params[:product])

    # Amount in cents
    @amount = @product[:discounted_price].to_f
    @amount = (@amount * 100).to_i

    begin
      customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
      )
      charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @product.name,
      :currency    => 'SGD'
      )
    rescue Stripe::CardError => e
      flash[:danger] = e.message
      redirect_to product_path(@product)
    end

    order = Order.new()
    order.user = current_user
    order.product = @product
    order.paid = @product[:discounted_price]

    if order.save
      flash[:success] = "Successfully purchased product"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to purchase product. Please try again later."
      redirect_to product_path(@product)
    end

  end

  # def show
  # end
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end

end
