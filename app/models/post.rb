# == Schema Information
# Schema version: 20100829210229
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates :content, :presence => true, :length => { :maximum => 600 }
  validates :user_id, :presence => true
  
  default_scope :order => 'posts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private
  
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            :user_id => user)
    end
end