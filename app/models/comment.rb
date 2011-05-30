class Comment < ActiveRecord::Base
  attr_accessible :content
  attr_accessible :post_id
  
  belongs_to :user
  belongs_to :post
  
  validates :content, :presence => true, :length => { :maximum => 600 }
  validates :user_id, :presence => true
  validates :post_id, :presence => true
  
end
