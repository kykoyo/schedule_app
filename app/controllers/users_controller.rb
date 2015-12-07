class UsersController < ApplicationController
  before_filter :authenticate_user!

  def update
    @user=User.find(params[:id])
    user_suggestion_params=params.require(:user).permit(user_suggestions_attributes: [:id, :suggestion_date, :tag])        
    @user.update(user_suggestion_params)
    flash[:notice]='出欠を入力しました'
    redirect_to user_events_path(@user)
  end

end