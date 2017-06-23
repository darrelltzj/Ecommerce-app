class DashboardController < ApplicationController
  before_action :is_authenticated
  before_action :user_is_seller

  def index
    
  end

end
