class NotificationsController < ApplicationController
  def seen
    respond_to do |format|
      format.js 
    end
  end
end