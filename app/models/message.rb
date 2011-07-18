class Message < ActiveRecord::Base
  belongs_to :receiver, :class_name => "User"
  belongs_to :sender, :class_name => "User"
  after_create :send_message_email
  
  def send_message_email
    UserMailer.message_email(self).deliver
  end
  
  
end