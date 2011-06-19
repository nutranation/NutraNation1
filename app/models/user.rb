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
  attr_accessor   :password
  attr_accessible :name, :email, :expertise, :occupation, :city, :state, :password, :password_confirmation, :avatar

  has_many :posts,    :dependent => :destroy
  has_many :comments,    :dependent => :destroy
  has_many :events,    :dependent => :destroy
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
  validates :email, :presence   => true,
  :format     => { :with => email_regex },
  :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true,
  :confirmation => true,
  :length => { :within => 6..40 }

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def following?(followed, item_type)
    relationships.where("followed_id = ? AND item_type = ?", followed.id, item_type).first
  end

  def follow!(followed, item_type)
    relationships.create!(:followed_id => followed.id, :item_type => item_type)
  end

  def unfollow!(followed)
    relationships.find(followed).destroy
  end

  class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user : nil
    end

  def authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  end
  def display_image
    if self.avatar_file_name
      (self.avatar.url(:thumb))
    else
      i = "male.jpeg"
    end
  end
  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
