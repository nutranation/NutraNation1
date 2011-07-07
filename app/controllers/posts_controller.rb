class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorized_user, :only => :destroy
  
  def create
    @post = current_user.posts.build(params[:post])
    @post.tag_list = params[:post][:tag_list].gsub(/\(\w+\)/, '')
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
    @related = @post.find_related_tags.limit(3)
  end
  
  def update
     @post = Post.find(params[:id])
     @post.tag_list = params[:post][:tag_list].gsub(/\(\w\)/, '')
     if @post.update_attributes(params[:post])
       redirect_to @post, :flash => { :success => "Post updated." }
     else
       @title = "Edit Post"
       render 'edit'
     end
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