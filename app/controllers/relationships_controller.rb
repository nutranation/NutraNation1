class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

    def create 
      if params[:relationship][:item_type] == 'User'
        @following  = User.find(params[:relationship][:followed_id])
        @item_type = 'User'
      elsif  params[:relationship][:item_type] == 'Tag' 
        @following = Tag.find(params[:relationship][:followed_id])
        @item_type = 'Tag'
      elsif  params[:relationship][:item_type] == 'Post' 
        @following = Post.find(params[:relationship][:followed_id])
        @item_type = 'Post'
      end
      current_user.follow!(@following, params[:relationship][:item_type])
      respond_to do |format|
        format.html { redirect_to @following }
        format.js
      end
    end

    def destroy
      if params[:item_type] == 'User'
        @following = Relationship.find(params[:id]).followed
        @item_type = 'User'
      elsif params[:item_type] == 'Tag'
        r = Relationship.find(params[:id]).followed_id
        @following = Tag.find r
        @item_type = 'Tag'
      elsif params[:item_type] == 'Post'
        r = Relationship.find(params[:id]).followed_id
        @following = Post.find r
        @item_type = 'Post'
      end
      current_user.unfollow!(params[:id])
      respond_to do |format|
        format.html { redirect_to @following }
        format.js 
      end
    end
  end