class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user==nil
        redirect_to root_path
    end
    
  end
  def new_user_suggestion
    current_user.user_suggestion.build
  end
  def create_user_suggestion
  end

  def edit_user_suggestion
    @event=Event.find(params[:id])
    @user=User.find(params[:id])
    @votes=Suggestion.where(event_id: @event.id)
    @user_suggestions=UserSuggestion.where(event_id: @event.id)
  end

  def update_user_suggestion
    @user_suggestions=UserSuggestion.where(event_id: @event.id)
    @votes=Suggestion.where(event_id: @event.id)
    user_suggestion_params=params.require(:user).permit(user_suggestion)
  end

end