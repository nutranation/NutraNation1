class Notification < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :user
  
  
  
  
end