class PostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  
  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      redirect_to root_path, :flash => { :success => "Post created!" }
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comment.post_id = @post.id
    @c_comment = Comment.where("post_id = ?", @post.id)
  end

  def destroy
    @post.destroy
    redirect_to root_path, :flash => { :success => "Post deleted!" }
  end
  
  private
  
    def authorized_user
      @post = Post.find(params[:id])
      redirect_to root_path unless current_user?(@post.user)
    end
end