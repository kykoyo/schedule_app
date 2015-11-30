class EventsController < ApplicationController
    before_filter :authenticate_user!


    def index
        #自分が開催するイベント及び招待されたイベントを表示する
        @owner_events=User.find(current_user).created_events
        @invited_events=User.find(current_user).events
    end
    def show
        #作成したイベントの詳細を表示
        @event=Event.find(params[:id])
    end
    def new
        @event=Event.new
    end
    def create
        event_params=params.require(:event).permit(:title, {:user_ids => []}, :held_at)
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
            redirect_to events_path, notice: "Event deleted"
        end

    end
    def edit
        @event=Event.find(params[:id])
    end
    def update
        @event=Event.find(params[:id])
        event_params=params[:event].permit(:title, :user_id, :held_at)

        @event.update(event_params)
        render 'show'
    end


    private
    #入力されたテキストを元に候補日を作成する
    def set_suggestion_date
        suggestion_obj=params[:Suggestion_Date]
        suggestion_lines=suggestion_obj.split("\n")

        suggestion_lines.each do |line|
            line.chomp!
            suggestion_date=Suggestion.new(suggestion_date: line, event_id: @event.id, count_good: 0, count_soso: 0, count_bad: 0)
            suggestion_date.save
        end
    end

end
