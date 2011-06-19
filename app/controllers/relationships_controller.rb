class RelationshipsController < ApplicationController
  before_filter :authenticate

    def create 
      if params[:relationship][:item_type] == 'User'
        @user = User.find(params[:relationship][:followed_id])
        current_user.follow!(@user, params[:relationship][:item_type])
        respond_to do |format|
          format.html { redirect_to @user }
          format.js { render :action => "create_user" }
        end
      else
        @tag = Tag.find(params[:relationship][:followed_id])
        current_user.follow!(@tag, params[:relationship][:item_type])
        respond_to do |format|
          format.html { redirect_to @tag }
          format.js { render :action => "create_tag" }
        end
      end
    end

    def destroy
      if params[:item_type] == 'User'
        @user = Relationship.find(params[:id]).followed
        current_user.unfollow!(params[:id])
        respond_to do |format|
          format.html { redirect_to @user }
          format.js { render :action => "destroy_user" }
        end
      else
        r = Relationship.find(params[:id]).followed_id
        @tag = Tag.find r
        current_user.unfollow!(params[:id])
        respond_to do |format|
          format.html { redirect_to @tag }
          format.js { render :action => "destroy_tag" }
        end
      end
    end
  end