class Comment < ActiveRecord::Base
  attr_accessible :content
  attr_accessible :post_id
  
  belongs_to :user
  belongs_to :post, :touch => true
  has_many :votes, :as => :content, :dependent => :destroy
  has_many :votes, :as => :content, :dependent => :destroy
  
  validates :content, :presence => true, :length => { :maximum => 600 }
  validates :user_id, :presence => true
  validates :post_id, :presence => true
  
  after_create :send_comment_email
  
  def send_comment_email
    unless self.post.user == self.user
      UserMailer.comment_email(self).deliver
    end
  end
  
end
