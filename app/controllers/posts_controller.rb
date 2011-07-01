class PostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  autocomplete :tag, :name, :full => true, :display_value => :display
  
  def create
    @post = current_user.posts.build(params[:post])
    @post.tag_list = params[:post][:tag_list].gsub(/\(\w\)/, '')
    if @post.save
      redirect_to root_path, :flash => { :success => "Post successful!" }
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comment.post_id = @post.id
    @c_comment = @post.order_comments
    @unique = true
    @tags = @post.find_tags
    @item_type = 'Post'
    @content_type = @item_type
    @following = @post
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