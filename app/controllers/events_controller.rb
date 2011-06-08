class EventsController < ApplicationController
  def index
    @all_events = Event.all
  end
  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.build(params[:event])
    date = DateTime.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i, params[:start_date][:hour].to_i, params[:start_date][:minute].to_i)
    @event.start_date = date
    if @event.save
      redirect_to root_path, :flash => { :success => "Event Created!" }
    else
      @feed_items = []
      render 'pages/home'
    end
  end
end
