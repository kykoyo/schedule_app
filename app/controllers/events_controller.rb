class EventsController < ApplicationController
    before_filter :authenticate_user!


    def index
        #自分が開催するイベント及び招待されたイベントを表示する
        @created_events = User.find(current_user).created_events.where(determine_date_id: nil)
        @determined_events = User.find(current_user).events.where.not(determine_date_id: nil)
        @invited_events = User.find(current_user).events.where(determine_date_id: nil)
    end

    def show
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
    end

    def new
        @user = User.find(params[:user_id])
        @event = Event.new()
    end

    def create
        @user = User.find(params[:user_id])
        event_params = params[:event].permit(:title, {:user_ids => []}, :price)
        @event = Event.new(event_params)
        @event.owner = current_user

        if @event.save
            set_suggestion_date

            flash[:notice] = 'イベントが作成されました'
            render 'show'
        else
            flash[:error] = 'イベント名が入力されていません'
            render 'new'
        end
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        if @event.destroy
            redirect_to user_events_path, notice: "Event deleted"
        end
    end

    def edit
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
        if @event.owner != current_user
            flash[:error] = '不正なアクセスです'
            redirect_to user_events_path
            return
        elsif @event.determine_date != nil
            flash[:error] = 'イベントの日程がすでに決まっています'
            redirect_to user_events_path
            return
        end
        suggestions_block = Suggestion.where(event_id: @event.id)

        #候補日をモデルから引っ張ってきて改行を含めて初期値として渡す
        @suggestions = ""
        suggestions_block.each do |suggestion|
            @suggestions += suggestion.suggestion_date
            @suggestions += "\n"
        end
    end

    def update
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
        event_params = params[:event].permit(:title, {:user_ids => []}, :price)

        if @event.update(event_params)
            set_suggestion_date

            flash[:notice] = 'イベントが変更されました'
            render 'show'
        else
            flash[:error] = 'イベント名が入力されていません'
            render 'edit'
        end
    end

    def determine_date
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
        @suggestions = Suggestion.where(event_id: params[:id])
    end

    def determine_post
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
        event_params = params[:event].permit(:determine_date_id)
        @event.update(event_params)
        flash[:notice] = 'イベントの日程を確定しました'
        redirect_to show_determine_path(@user, @event)
    end

    def determine_cancel
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
        @event.update(determine_date_id: nil)
        flash[:warning] = 'イベントの日程をキャンセルしました'
        redirect_to user_events_path(@user, @event)
    end

    def show_determine
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
    end


    private
    #入力されたテキストを元に候補日を作成する
    def set_suggestion_date
        suggestion_block = params[:Suggestion_Date]
        suggestion_lines = suggestion_block.split("\n")

        suggestion_lines.each do |line|
            line.chomp!
            suggestion_date = Suggestion.find_by_suggestion_date(line)
            if suggestion_date == nil
                suggestion_date = Suggestion.new(suggestion_date: line, event_id: @event.id)
                suggestion_date.save
                @event.users.each do |user|
                    user_suggestion = UserSuggestion.create(user_id: user.id, suggestion_id: suggestion_date.id, tag: 0)
                end
            end
        end
    end

end
