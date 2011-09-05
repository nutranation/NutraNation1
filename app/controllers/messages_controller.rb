class MessagesController < ApplicationController
  def inbox
    @messages = Message.where('receiver_id = ?', current_user.id).order("created_at DESC")
    @inbox = :inbox
  end
  def sent
    @messages = Message.where('sender_id = ?', current_user.id).order("created_at DESC")
    @inbox = :sent
  end
  
  def create
    @receiver = User.find(params[:message][:receiver_id])
    if @receiver
      @message = Message.create(:subject => params[:message][:subject], 
                                :body => params[:message][:body],
                                :receiver_id => @receiver.id, 
                                :sender_id => current_user.id)
      if params[:message][:parent]
        @message.parent = params[:message][:parent]
      end
      @message.save!
      redirect_to  "/messages/#{current_user.id}/inbox"
    else
      redirect_to  new_message_path, :flash => { :error => "Not A Valid User!" }
    end
  end
  
  def show
    @message = Message.find(params[:id])
    @message.seen = true
    @message.save!
    unless current_user
      redirect_to root_path
    end
  end
end