class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @users = User.all
    @title = "All users"
  end
  
  def show
    @user = User.find(params[:id])
    @following = @user
    @feed_items =  Kaminari.paginate_array(@user.my_activity).page(params[:page])
    @title = @user.name
    @item_type = 'User'
    @feed_type = :my_activity
  end
  
  

  

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end
  
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followed_users
    render 'show_follow'
  end
  
  def following_tags
    @title = "Tags"
    @user = User.find(params[:id])
    @tags = @user.following_tags
    render 'show_tags'
  end
  def following_posts
    @post = Post.new
    @user = User.find(params[:id])
    @feed_items  = @user.following_posts
    @feed_type = :following
    render 'show_posts'
  end

  
  def edit
    @title = "Edit Profile"
  end
  

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end
