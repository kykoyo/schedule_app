class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user==nil
        redirect_to root_path
    end
    
  end

end