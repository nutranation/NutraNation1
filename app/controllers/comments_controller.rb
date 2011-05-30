class CommentsController < ApplicationController
  
  def create
     @comment = current_user.comments.build(params[:comment])
     @comment.save!
     if @comment.save
       render 'pages/contact'
     else
       @feed_items = []
       render 'pages/home'
     end
   end
   
   def destroy
     @comment.destroy
     redirect_to root_path, :flash => { :success => "Post deleted!" }
   end

   private

     def authorized_user
       @comment = Post.find(params[:id])
       redirect_to root_path unless current_user?(@commen.user)
     end
 
end
