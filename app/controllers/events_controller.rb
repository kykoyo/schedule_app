class EventsController < ApplicationController
    before_filter :authenticate_user!


    def index
        #自分が開催するイベント及び招待されたイベントを表示する
        @created_events = User.find(current_user).created_events.where(held_at: nil)
    
        participant_events = User.find(current_user).events
        @determined_events = participant_events.where.not(held_at: nil)
        @invited_events = participant_events.where(held_at: nil)
    end
    def show
        @user=User.find(params[:user_id])
        @event=Event.find(params[:id])
    end
    def new
        @user=User.find(params[:user_id])
        @event=Event.new()
    end
    def create
        @user=User.find(params[:user_id])
        event_params=params[:event].permit(:title, {:user_ids => []}, :price)
        @event=Event.new(event_params)
        @event.owner=current_user

        @event.save

        set_suggestion_date

        render 'show'
    end
    def destroy
        @event=Event.find(params[:id])
        @event.destroy
        if @event.destroy
            redirect_to user_events_path, notice: "Event deleted"
        end

    end
    def edit
        @user=User.find(params[:user_id])
        @event=Event.find(params[:id])
        suggestions_block=Suggestion.where(event_id: @event.id)
        @suggestions=""
        suggestions_block.each do |suggestion|
            @suggestions+=suggestion.suggestion_date
            @suggestions+="\n"
        end
    end
    def update
        @user=User.find(params[:user_id])
        @event=Event.find(params[:id])
        event_params=params[:event].permit(:title, :user_id, :held_at)

        @event.update(event_params)
        render 'show'
    end

    def determine_date
        @user=User.find(params[:user_id])
        @event=Event.find(params[:id])
        @suggestions=Suggestion.where(event_id: params[:id])
    end

    def determine_post
        @user=User.find(params[:user_id])
        @event=Event.find(params[:id])
        event_params=params[:event].permit(:held_at)
        @event.update(event_params)
        flash[:notice]='イベントの日程を確定しました'
        render 'show'
    end

    def determine_cancel
        @user=User.find(params[:user_id])
        @event=Event.find(params[:id])
        @event.update(held_at: nil)
        redirect_to determine_date_path(@user, @event)
    end


    private
    #入力されたテキストを元に候補日を作成する
    def set_suggestion_date
        suggestion_obj=params[:Suggestion_Date]
        suggestion_lines=suggestion_obj.split("\n")

        suggestion_lines.each do |line|
            line.chomp!
            suggestion_date=Suggestion.new(suggestion_date: line, event_id: @event.id)
            suggestion_date.save
            @event.users.each do |user|
                user_suggestion=UserSuggestion.create(user_id: user.id, suggestion_id: suggestion_date.id, tag: 0)
            end
        end
    end

end
