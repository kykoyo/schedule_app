class UserSuggestionsController < ApplicationController
    def new
        @user=User.find(params[:user_id])
        @event=Event.find(params[:event_id])
        @user_suggestions=UserSuggestion.new()
        @user.user_suggestions.build
    end
    
    def create
        user_suggestion_params=params.require(:user).permit(user_suggestions_attributes: [:id, :suggestion_date, :tag])
    end

    def edit
        @user=User.find(params[:user_id])
        @event=Event.find(params[:event_id])
        @user_suggestions=@user.user_suggestions
    end

    def update
        user_suggestion_params=params.require(:user).permit(user_suggestions_attributes: [:id, :suggestion_date, :tag])        
        @user_suggestions.update(user_suggestion_params)
        redirect_to user_events_path(current_user)
    end

end
