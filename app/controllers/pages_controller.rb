class PagesController < ApplicationController

  def home
    @tite = "Live"
    if user_signed_in?
      @post = Post.new
      @feed_items = Post.order('updated_at DESC').page(params[:page])
      @feed_type = :live
    end
  end
  
  def subscribed
    @title = "Home"
    if user_signed_in?
      @post = Post.new
      @feed_items = current_user.feed.page(params[:page])
      @feed_type = :subscribed
    end
  end
  
  def highest_voted
    @title = "Home"
    if user_signed_in?
      @post = Post.new
      @feed_items = Post.highest_voted('2011-05-15').page(params[:page])
      @feed_type = :highest_voted
    end
  end
  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def search
    @search = params[:search]
    @feed_items = Post.search_by_content(@search).page(params[:page])
    @users = User.search_by_name(@search)
    @feed_type = :search
  end
  
end
