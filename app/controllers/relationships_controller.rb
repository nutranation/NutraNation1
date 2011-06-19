class RelationshipsController < ApplicationController
  before_filter :authenticate

    def create 
      if params[:relationship][:item_type] == 'User'
        @user = User.find(params[:relationship][:followed_id])
        current_user.follow!(@user, params[:relationship][:item_type])
        respond_to do |format|
          format.html { redirect_to @user }
          @item_type = 'User'
          @following = @user
          format.js { render :action => "create_user" }
        end
      else
        @tag = Tag.find(params[:relationship][:followed_id])
        current_user.follow!(@tag, params[:relationship][:item_type])
        respond_to do |format|
          format.html { redirect_to @tag }
          @item_type = 'Tag'
          @following = @tag
          format.js { render :action => "create_user" }
          
        end
      end
    end

    def destroy
      if params[:item_type] == 'User'
        @user = Relationship.find(params[:id]).followed
        current_user.unfollow!(params[:id])
        respond_to do |format|
          format.html { redirect_to @user }
          @item_type = 'User'
          @following = @user
          format.js { render :action => "destroy_user" }
         
        end
      else
        r = Relationship.find(params[:id]).followed_id
        @tag = Tag.find r
        current_user.unfollow!(params[:id])
        respond_to do |format|
          @item_type = 'Tag'
          @following = @tag
          format.html { redirect_to @tag }
          format.js { render :action => "destroy_user" }
        end
      end
    end
  end