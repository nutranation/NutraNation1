class MessagesController < ApplicationController
  def inbox
    @messages = Message.where('receiver_id = ?', current_user.id) 
    @inbox = :inbox
  end
  def sent
    @messages = Message.where('sender_id = ?', current_user.id) 
    @inbox = :sent
  end
  
  def create
    @receiver = User.find_by_name(params[:message][:receiver])
    if @receiver
      @message = Message.create(:subject => params[:message][:subject], 
                                :body => params[:message][:body],
                                :receiver_id => @receiver.id, 
                                :sender_id => current_user.id)
      @message.save!
      redirect_to  "/messages/#{current_user.id}/inbox"
    else
      redirect_to  new_message_path, :flash => { :error => "Not A Valid User!" }
    end
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
end