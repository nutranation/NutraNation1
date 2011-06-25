class PagesController < ApplicationController

  def home
    @tite = "Live"
    if signed_in?
      @post = Post.new
      @feed_items = Post.all.paginate(:page => params[:page])
      @feed_type = :live
    end
  end
  
  def subscribed
    @title = "Home"
    if signed_in?
      @post = Post.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      @feed_type = :subscribed
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
end
