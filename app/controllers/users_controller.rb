class UsersController < ApplicationController
  before_action :is_authenticated, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # Code.create(code:BCrypt::Password.create("*******"))
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:danger] = "Passwords do not match. Please try again"
      render :new
    elsif params[:user][:password].length < 6 || params[:user][:password].length > 20
      flash[:danger] = "Password must be between 6 to 20 characters. Please try again"
      render :new
    elsif params[:user][:is_seller] == true && BCrypt::Password.new(Code.find(1).code) != params[:user][:code]
      flash[:danger] = "Seller Code is invalid. Please try again."
      render :new
    else
      new_user = User.new(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      email: params[:user][:email],
      is_seller: params[:user][:is_seller],
      password: params[:user][:password],
      # is_active: true
      )

      if new_user.save
        session[:user_id] = new_user.id
        flash[:success] = "Successfully created an account"
        if current_user.is_seller
          redirect_to products_path
        else
          redirect_to orders_path
        end
      else
        flash[:danger] = "Unable to create account. Please check parameters."
        render :new
      end
    end
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if BCrypt::Password.new(current_user.password_digest) != params[:user][:password_current]
      flash[:danger] = "Incorrect Password. Please try again"
      render :edit

    elsif params[:commit] == 'Update'
      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:danger] = "New Passwords do not match. Please try again"
        render :edit
      elsif params[:user][:password].length < 6 || params[:user][:password].length > 20
        flash[:danger] = "Password must be between 6 to 20 characters. Please try again"
        render :edit
      elsif params[:user][:is_seller] == true && BCrypt::Password.new(Code.find(1).code) != params[:user][:code]
        flash[:danger] = "Seller Code is invalid. Please try again."
        render :edit
      else
        current_user.first_name = params[:user][:first_name]
        current_user.last_name = params[:user][:last_name]
        current_user.email = params[:user][:email]
        current_user.is_seller = params[:user][:is_seller]
        current_user.password = params[:user][:password]
        if current_user.save
          if !current_user.is_seller
            current_user.products.each do |product|
              product.status = 'unavailable'
              product.save!
            end
          end
          flash[:success] = "Successfully updated account"
          if current_user.is_seller
            redirect_to products_path
          else
            redirect_to orders_path
          end
        else
          flash[:danger] = "Unable to edit account. Please check parameters."
          render :edit
        end
      end

    elsif params[:commit] == 'Deactivate Account'
      current_user.products.each do |product|
        product.status = 'unavailable'
        product.save!
      end
      current_user.is_seller = false

      # current_user.is_active = false
      # current_user.email = "#{current_user.id}@email.com"
      # current_user.password_digest = (0...8).map { (65 + rand(26)).chr }.join

      if current_user.save
        session[:user_id] = nil
        redirect_to root_path
      else
        flash[:danger] = "Unable to delete account."
        render :edit
      end
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_seller, :code, :current_password, :password, :password_confirmation)
  end
end
