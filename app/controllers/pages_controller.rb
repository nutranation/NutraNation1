class PagesController < ApplicationController

  def home
    @tite = "Live"
    if signed_in?
      @post = Post.new
      @feed_items = Post.order('updated_at DESC')
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
  
  def highest_voted
    @title = "Home"
    if signed_in?
      @post = Post.new
      @feed_items = Post.highest_voted('2011-05-15')
      @feed_type = :highest_voted
    end
  end
  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
end
