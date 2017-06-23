class UsersController < ApplicationController
  before_action :is_authenticated, except: [:new, :create]

  def new
  end

  def create
    # Code.create(code:BCrypt::Password.create("*******"))
    p params[:user]
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:danger] = "Passwords do not match. Please try again"
      render :new
    elsif params[:user][:password].length < 6 || params[:user][:password].length > 20
      flash[:danger] = "Password must be between 6 to 20 characters. Please try again"
      render :new
    elsif params[:user][:code] && BCrypt::Password.new(Code.find(1).code) != params[:user][:code]
      flash[:danger] = "Seller Code is invalid. Please try again."
      render :new
    else
      new_user = User.new(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], is_seller: user_params[:is_seller], password: user_params[:password], is_active: true)

      # new_user[:first_name] = user_params[:first_name]
      # new_user[:last_name] = user_params[:last_name]
      # new_user[:email] = user_params[:email]
      # new_user[:is_seller] = user_params[:is_seller]
      # new_user[:password] = user_params[:password]

      p 'user', new_user, user_params

      if new_user.save
        session[:user_id] = new_user.id
        flash[:success] = "Successfully created an account"
        # redirect to store if Seller
        # redirect to products if buyer
        redirect_to root_path
      else
        flash[:danger] = "Unable to create account. Please check parameters."
        render :new
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_seller, :password, :password_confirmation)
  end
end
