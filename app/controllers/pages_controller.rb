class PagesController < ApplicationController

  def home
    @tite = "Home"
    if user_signed_in?
      @post = Post.new
      @feed_items = Post.order('updated_at DESC').page(params[:page])
      @feed_type = :live
    end
  end
  
  def subscribed
    @title = "Subscription"
    if user_signed_in?
      @post = Post.new
      @feed_items = Kaminari.paginate_array(current_user.feed).page(params[:page])
      @feed_type = :subscribed
    end
  end
  
  def highest_voted
    @title = "Home"
    if user_signed_in?
      @post = Post.new
      @feed_items = Kaminari.paginate_array(Post.highest_voted('2011-05-15')).page(params[:page])
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
    @search = params[:search_form].downcase
    redirect_to @search
  end
  def register
    sql = "INSERT INTO waiting (email) VALUES('#{params[:email]}');"
  	User.connection.select_all(sql)
  	UserMailer.waiting_email(params[:email]).deliver
  	UserMailer.welcome_email_waiting(params[:email]).deliver
    render 'about'
  end
  
end
