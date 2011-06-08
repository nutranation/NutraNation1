class EventsController < ApplicationController
  def index
     @event = Event.new
  end
  
  def create
    @event = current_user.posts.build(params[:event])
    if @event.save
      redirect_to root_path, :flash => { :success => "Event created!" }
    else
      @feed_items = []
      render 'pages/home'
    end
  end
end
