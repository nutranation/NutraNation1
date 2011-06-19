class RelationshipsController < ApplicationController
  before_filter :authenticate

    def create 
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user, params[:relationship][:item_type])
      respond_to do |format|
        format.html { redirect_to @user }
        if params[:relationship][:item_type] == 'User'
          format.js { render :action => "create_user" }
        else
          format.js { render :action => "create_tag" }
        end
      end
    end

    def destroy
      @user = Relationship.find(params[:id]).followed
      current_user.unfollow!(params[:id])
      respond_to do |format|
        format.html { redirect_to @user }
        if params[:item_type] == 'User'
          format.js { render :action => "destroy_user" }
        else
          format.js { render :action => "destroy_tag" }
        end
      end
    end
  end