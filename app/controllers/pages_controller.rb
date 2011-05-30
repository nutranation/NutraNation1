class PagesController < ApplicationController

  def home
    @title = "Home"
    if signed_in?
      @post = Post.new
      @feed_items = Post.all.paginate(:page => params[:page])
      @feed_type = :live
    end
  end
  
  def subscribed
    @post = Post.new
    @feed_items = current_user.feed.paginate(:page => params[:page])
    @feed_type = :subscribed
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
end
