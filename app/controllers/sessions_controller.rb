class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_and_authenticate_user(user_params)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged in."
      # redirect to store if Seller
      # redirect to products if buyer
      redirect_to root_path
    else
      flash[:danger] = "Credentials are invalid. Please try again"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
