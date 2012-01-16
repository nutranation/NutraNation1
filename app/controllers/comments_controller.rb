class CommentsController < ApplicationController
  
  def create
    puts "~~~~"
    puts params
    @comment = current_user.comments.build(params[:comment])
    @refresh = "/posts/#{@comment.post_id}"
    @post = @comment.post
    @user = @post.user
    @unique=true
    
    if @comment.save
      redirect_to( @refresh, :flash => { :success => "Comment created!" })
      @comments = @post.comments
      @comment.post.create_notifications(@comment)
    else
      @comments = @post.comments
      redirect_to( @refresh)
    end
  end
   
   
   def destroy
     @comment = Comment.find(params[:id])
     @refresh = "/posts/#{@comment.post_id}"
     @comment.destroy
     redirect_to @refresh, :flash => { :success => "Comment deleted!" }
   end

   private

     def authorized_user
       @comment = Comment.find(params[:id])
       redirect_to root_path unless current_user?(@comment.user)
     end
     
     
end
