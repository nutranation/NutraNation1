# == Schema Information
# Schema version: 20100829210229
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :title, :content
  
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :votes, :as => :imageable, :dependent => :destroy
  
  validates :title, :presence => true, :length => { :maximum => 600 }
  validates :user_id, :presence => true
  
  default_scope :order => 'posts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  acts_as_taggable
  def find_tags
    tags = Tag.joins("JOIN taggings AS tg ON tags.id = tg.tag_id 
                      JOIN posts AS p ON tg.taggable_id = p.id 
                      AND tg.taggable_type = 'Post'").where("p.id = ?", self.id)
  end
  def order_comments
    Comment.joins("JOIN (SELECT count(*) AS score, c.id AS id
          FROM comments AS c
          JOIN votes AS v
          ON v.content_id = c.id
            AND v.content_type = 'Comment'
          GROUP BY c.id) AS score
    ON comments.id = score.id").where("comments.post_id = ?", self).order("score.score DESC")
  end
  
  
  private
  
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            :user_id => user)
    end
end