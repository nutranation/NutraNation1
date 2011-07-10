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
  
  attr_accessible :title, :content, :picture
  
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :votes, :as => :content, :dependent => :destroy
  
  validates :title, :presence => true, :length => { :maximum => 600 }
  validates :user_id, :presence => true
  
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :storage => :s3,
       :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
       :path => "/:style/:id/:filename"
  
  
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  acts_as_taggable
  def self.highest_voted(date)
    self.select("distinct posts.*, COALESCE(sum(v.value), 0) ").joins("LEFT JOIN votes AS v 
                ON v.content_id = posts.id 
                  AND v.content_type = 'Post'").where("posts.created_at > ?", date).group("posts.id, 
                  posts.title, posts.content, posts.user_id, 
                  posts.created_at, posts.updated_at, posts.picture_file_name, posts.picture_content_type,
                  posts.picture_file_size, posts.picture_updated_at").
                  order("COALESCE(sum(v.value), 0) DESC").uniq
  end
  
  def find_tags
    tags = Tag.joins("JOIN taggings AS tg ON tags.id = tg.tag_id 
                      JOIN posts AS p ON tg.taggable_id = p.id 
                      AND tg.taggable_type = 'Post'").where("p.id = ?", self.id)
  end
  
  def order_comments
    Comment.joins("JOIN (SELECT COALESCE(sum(value), 0) AS score, c.id AS id
              FROM comments AS c
              LEFT JOIN votes AS v
              ON v.content_id = c.id
                AND v.content_type = 'Comment'
              GROUP BY c.id) AS score
    ON comments.id = score.id").where("comments.post_id = ?", self).order("score.score DESC")
  end
  
  def up_voted(user)
    votes = Vote.where("content_id = ? AND content_type = 'Post' AND value = 1", self.id)
    following = user.following_users
    match = []
    votes.each do |v|
      following.each do |f|
        if v.user_id == f.id
          match << f
        end
      end
    end
    match
  end
  
  def self.search(item)
    item = item.downcase 
    Post.joins("LEFT JOIN comments AS c ON c.post_id = posts.id").where("lower(posts.title) LIKE '%#{item}%' 
                                                              OR lower(posts.content) LIKE '%#{item}%' 
                                                              OR lower(c.content) LIKE '%#{item}%'")
                                                              .order("CASE
                                                                        WHEN lower(c.content) LIKE '%#{item}%' THEN c.created_at
                                                                        ELSE posts.created_at
                                                                      END").uniq
                                                                        
  end
  
  
end