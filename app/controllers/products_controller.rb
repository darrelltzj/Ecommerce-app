class ProductsController < ApplicationController
  before_action :is_authenticated
  before_action :user_is_seller, except: [:show]
  before_action :js_only, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :product_is_available, only: [:show]

  # before_action :all_products

  def index
    @products = Product.where(user: current_user)
    @products_available = @products.where(status: 'available')
    @products_unavailable = @products.where(status: 'unavailable')
    @product = Product.new
    # gon.products = Product.where(user: current_user)
  end

  def new
    @product = Product.new
    render :form
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:success] = "Successfully added product."
      redirect_to products_path
    else
      flash[:danger] = "Unable to update product. Please check parameters."
      render :form
    end
  end

  def show
  end

  def edit
    render :form
  end

  def update
    if !product_params[:image]
      product_params[:image] = @product.image
    end
    if @product.update(product_params)
      flash[:success] = "Successfully updated product."
      redirect_to products_path
    else
      flash[:danger] = "Unable to update product. Please check parameters."
      render :form
    end
  end

  def destroy
    if @product.update(status: 'removed')
      flash[:success] = "Successfully removed product."
      redirect_to products_path
    else
      flash[:danger] = "Unable to remove product."
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  # def all_products
  #   @products = Product.where(user: current_user)
  # end

  def product_params
    params.require(:product).permit(:name, :description, :status, :original_price, :discounted_price, :image)
  end

  def js_only
    if request.format != 'js'
      redirect_to products_url, notice: 'Javascript Only'
    end
  end

end
