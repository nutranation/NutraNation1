class VotesController < ApplicationController
  def create
    if params[:vote][:content_type] == 'Post'
      @content = Post.find(params[:vote][:content_id])
    else
      @content = Comment.find(params[:vote][:content_id])
    end
    @vote = Vote.create(:user_id => current_user.id, 
                        :content_id => params[:vote][:content_id], 
                        :content_type => params[:vote][:content_type],
                        :value => params[:vote][:value])
    @vote.save!
    respond_to do |format|
      format.html { redirect_to @content }
      format.js
    end
  end
end