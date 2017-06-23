class ProductsController < ApplicationController
  before_action :is_authenticated
  before_action :user_is_seller

  before_action :js_only, except: [:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # before_action :all_products
  # respond_to :html, :js

  def index
    @products = Product.where(user: current_user)
    @product = Product.new
    # gon.products = Product.where(user: current_user)
  end

  def new
    @product = Product.new
    render :form
  end

  def create
    # if product_params[:image_url] && product_params[:image_url].path
    #   uploaded_file = product_params[:image_url].path
    #   @cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
    # end

    @product = Product.new(product_params)
    @product.user = current_user

    # if product_params[:image_url] && product_params[:image_url].path
    #   @product.image_url = @cloudinary_file["secure_url"]
    # end

    if @product.save
      redirect_to products_path
    else
      render :form
    end
  end

  def show
  end

  def edit
    render :form
  end

  def update
    # if product_params[:image_url] && product_params[:image_url].path
    #   uploaded_file = product_params[:image_url].path
    #   @cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
    # end

    # if product_params[:image_url] && product_params[:image_url].path
    #   @product.image_url = @cloudinary_file["secure_url"]
    # end

    if @product.update(product_params)
      redirect_to products_path
    else
      render :form
    end
  end

  def destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  # def all_products
  #   @products = Product.where(user: current_user)
  # end

  def product_params
    params.require(:product).permit(:name, :description, :is_available, :original_price, :discounted_price)
  end

  def js_only
    if request.format != 'js'
      redirect_to products_url, notice: 'Javascript Only'
    end
  end

end
