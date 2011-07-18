# == Schema Information
# Schema version: 20100831012055
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :item_type
  
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"
  has_many :notifications, :as => :item, :dependent => :destroy
  
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
  validates :item_type, :presence => true
  
  after_create :send_follower_email
  
  def send_follower_email
    if self.item_type == 'User'
      UserMailer.follower_email(self).deliver
    end
  end
  
end
