class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic => true
  belongs_to :user
  
  def self.count(content_type, content_id) 
    self.where("content_type = ? AND content_id = ?", content_type, content_id).sum("value")
  end
  
end