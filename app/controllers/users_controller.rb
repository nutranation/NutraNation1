class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @users = User.all
    @title = "All users"
  end
  
  def show
    @user = User.find(params[:id])
    @following = @user
    @feed_items = @user.my_activity
    @title = @user.name
    @item_type = 'User'
    @feed_type = true
  end
  def show_questions
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

  def new
    @user  = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome_email(@user).deliver
      sign_in @user
      redirect_to root_path, :flash => { :success => "Welcome to the Sample App!" }
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Profile"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit Profile"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
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
