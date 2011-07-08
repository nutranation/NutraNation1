class TagsController < ApplicationController

  def show
    @item_type = "Tag"
    @tag = Tag.find(params[:id])
    @following =  @tag
    @feed_items = @tag.all_posts.page(params[:page])
    @feed_type = :tag
  end
  def index
    @tags = Tag.all
  end
end