  # == Schema Information
  # Schema version: 20100829021049
  #
  # Table name: users
  #
  #  id                 :integer         not null, primary key
  #  name               :string(255)
  #  email              :string(255)
  #  created_at         :datetime
  #  updated_at         :datetime
  #  encrypted_password :string(255)
  #  salt               :string(255)
  #  admin              :boolean
  #

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :description, :location, :avatar, :email, :password, :password_confirmation
  
  has_many :posts,    :dependent => :destroy
  has_many :votes
  has_many :notifications
  has_many :comments,    :dependent => :destroy
  has_many :events,    :dependent => :destroy
  has_many :relationships, :dependent => :destroy,
  :foreign_key => "follower_id"
  
  has_many :messages, :dependent => :destroy,
  :foreign_key => "receiver_id"
  
  has_many :sent_messages, :dependent => :destroy,
  :foreign_key => "sender_id",
  :class_name => "Message"
  
  
  has_many :relationships, :dependent => :destroy,
  :foreign_key => "follower_id"
  
  has_many :reverse_relationships, :dependent => :destroy,
  :foreign_key => "followed_id",
  :class_name => "Relationship"
  
  
  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships,
  :source  => :follower
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :storage => :s3,
       :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
       :path => "/:style/:id/:filename"



  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
  :length   => { :maximum => 50 }

  def my_activity
    Post.joins("LEFT JOIN comments AS c
    ON c.post_id = posts.id
    LEFT JOIN votes AS v
    ON v.content_id = posts.id
    AND v.content_type = 'Post'").where("posts.user_id = :user_id 
    OR c.user_id = :user_id
    OR v.user_id = :user_id", :user_id => self.id).order("CASE
        WHEN c.user_id = #{self.id} THEN c.created_at
        WHEN posts.user_Id = #{self.id} THEN posts.created_at
        WHEN v.user_id = #{self.id} THEN v.created_at
     END
     DESC").uniq
  end
 
 
  def following?(followed, item_type)
    relationships.where("followed_id = ? AND item_type = ?", followed.id, item_type).first
  end
  
  def voted?(content_type, content_id)
    Vote.where("content_type = ? AND content_id = ? AND user_id = ?", content_type, content_id, self.id).first
  end

  def display_image
    if self.avatar_file_name
      (self.avatar.url(:thumb))
    else
      i = "male.jpeg"
    end
  end
  

  # subscription feed
  def feed
    ids = self.following_ids
    users = ids[:users].join(", ")
    tags = ids[:tags].join(", ")
    posts = ids[:posts].join(", ")
    
    Post.joins("LEFT JOIN comments AS c
    ON c.post_id = posts.id
    LEFT JOIN taggings AS t
    ON t.taggable_id = posts.id
    LEFT JOIN votes AS v
    ON v.content_id = posts.id
    AND v.content_type = 'Post'").where("posts.user_id IN(#{users})
    OR c.user_id IN(#{users})
    OR posts.id IN(#{posts})
    OR t.tag_id IN(#{tags})
    OR v.user_Id IN(#{users})").order("CASE 
        WHEN posts.user_id IN(#{users}) THEN posts.updated_at
        WHEN posts.id IN(#{posts}) THEN posts.updated_at
        WHEN t.tag_id IN(#{tags}) THEN posts.updated_at
        WHEN v.user_Id IN(#{users}) THEN v.created_at
        WHEN c.user_id IN(#{users}) THEN c.created_at
     END
     DESC").uniq
  end
  
  # helpers for subscription feed
  def following_tags
    Tag.joins("JOIN relationships AS r ON r.followed_id = tags.id").where("r.follower_id = ? AND r.item_type = 'Tag'", self.id)
  end
  
  def following_posts
    Post.joins("JOIN relationships AS r ON r.followed_id = posts.id").where("r.follower_id =? AND r.item_type = 'Post'", self.id).order("posts.updated_at DESC")
  end
  
  def following_users
    User.joins("JOIN relationships AS r ON r.followed_id = users.id").where("r.follower_id = ? AND r.item_type = 'User'", self.id)
  end
  
  def followed_users
    User.joins("JOIN relationships AS r ON r.follower_id = users.id").where("r.followed_id = ? AND r.item_type = 'User'", self.id)
  end

  def following_ids
    rl = Relationship.where("follower_id = ?", self.id)
    posts = []
    users = [self.id]
    tags = []
    rl.each do |r|
      case r.item_type
      when 'User'
        users << r.followed_id
      when 'Tag'
        tags << r.followed_id
      when 'Post'
        posts << r.followed_id
      end
    end
    
    unless posts.first
      posts << 'null'
    end
    
    unless tags.first
      tags << 'null'
    end
    
    following_ids = { :users => users, :tags => tags, :posts => posts }
  end
  
  def self.search(item)
    item = item.downcase 
    User.where("lower(users.name) LIKE '%#{item}%'") 
  end
  
  def notification_unseen
    Notification.where("user_id = ? AND seen is null AND (creator != ? OR creator IS null)", self.id, self.id).size
  end
  
  def notifications
    ne = Notification.where("user_id = ? AND seen is null AND (creator != ? OR creator IS null)", self.id, self.id).order('created_at DESC').limit(5)
    unless ne.first
      ne = Notification.where("user_id = ? AND (creator != ? OR creator IS null)", self.id, self.id).limit(5)
    end
    ne
  end
  
  def unread_messages
    Message.where("receiver_id = ? AND seen is not true", self.id).size
  end
  
  
  
  

## controller helper methods
  def follow!(followed, item_type)
    relationships.create!(:followed_id => followed.id, :item_type => item_type)
  end

  def unfollow!(followed)
    relationships.find(followed).destroy
  end

  def vote!(content, content_type)
    votes.create!(:content_id => content.id, :content_type => content_type)
  end



end
