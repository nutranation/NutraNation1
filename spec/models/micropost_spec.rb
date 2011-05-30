require 'spec_helper'

describe Post do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "lorem ipsum" }
  end
  
  it "should create a new instance with valid attributes" do
    @user.posts.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @post = @user.posts.create(@attr)
    end
    
    it "should have a user attribute" do
      @post.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @post.user_id.should == @user.id
      @post.user.should == @user
    end
  end
  
  describe "validations" do

    it "should have a user id" do
      Post.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.posts.build(:content => "    ").should_not be_valid
    end
    
    it "should reject long content" do
      @user.posts.build(:content => "a" * 141).should_not be_valid
    end
  end

  describe "from_users_followed_by" do
    
    before(:each) do
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))
      
      @user_post  = @user.posts.create!(:content => "foo")
      @other_post = @other_user.posts.create!(:content => "bar")
      @third_post = @third_user.posts.create!(:content => "baz")
      
      @user.follow!(@other_user)
    end
    
    it "should have a from_users_followed_by method" do
      Post.should respond_to(:from_users_followed_by)
    end
    
    it "should include the followed user's posts" do
      Post.from_users_followed_by(@user).should include(@other_post)
    end
    
    it "should include the user's own posts" do
      Post.from_users_followed_by(@user).should include(@user_post)
    end
    
    it "should not include an unfollowed user's posts" do
      Post.from_users_followed_by(@user).should_not include(@third_post)
    end
  end
end
