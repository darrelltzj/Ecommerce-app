class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_authenticated
    unless current_user
      flash[:danger] = "You must be logged in to access this page."
      redirect_to login_path
    end
  end

  def user_is_seller
    unless current_user.is_seller
      flash[:danger] = "You must be a seller to access this page."
      redirect_to profile_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def product_is_available
    unless @product.status == 'available'
      flash[:danger] = "Product is unavailable."
      redirect_to root_path
    end
  end

  helper_method :current_user
end
