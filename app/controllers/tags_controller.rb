class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @feed_items = @tag.all_posts.paginate(:page => params[:page])
  end
end