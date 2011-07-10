class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.build(params[:comment])
    @refresh = "/posts/#{@comment.post_id}"
    if @comment.save
      redirect_to( @refresh, :flash => { :success => "Comment created!" })
      @comment.post.create_notifications(@comment)
    else
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
