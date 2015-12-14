class UserSuggestionsController < ApplicationController
    #eventを作成した時に初期値を設定しているのでnewとcreateはかかない
    def edit
        @user = User.find(params[:user_id])
        @event = Event.find(params[:event_id])
        @suggestions = @user.suggestions.where(event_id: @event)
        @user_suggestions = []
        @suggestions.each do |suggestion|
            @user_suggestions << UserSuggestion.where(user_id: @user, suggestion_id: suggestion)
        end
        @user_suggestions.flatten!

    end

end
