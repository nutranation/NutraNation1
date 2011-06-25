class PagesController < ApplicationController

  def home
    @tite = "Live"
    if signed_in?
      @post = Post.new
      @feed_items = Post.order('updated_at')
      @feed_type = :live
    end
  end
  
  def subscribed
    @title = "Home"
    if signed_in?
      @post = Post.new
      @feed_items = current_user.feed
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
