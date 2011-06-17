class TagsController < ApplicationController

def show
  @tag = Tag.find(params[:id])
  @posts = @tag.all_posts
  @no_form = true
end