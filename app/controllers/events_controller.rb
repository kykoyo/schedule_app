class EventsController < ApplicationController
    before_filter :authenticate_user!


    def index
        #自分が開催するイベント及び招待されたイベントを表示する
        @owner_events=Event.where(owner_id: current_user)
        @invited_events=Event.where(user_id: current_user)
    end
    def show
        #作成したイベントの詳細を表示
        @event=Event.find(params[:id])
    end
    def new
        @event=Event.new
    end
    def create
        event_params=params[:event].permit(:title, :user_id, :held_at)
        @event=Event.new(event_params)
        @event.owner=current_user

        @event.save
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
end
