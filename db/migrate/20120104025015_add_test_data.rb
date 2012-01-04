class AddTestData < ActiveRecord::Migration
  def self.up

    @spencer = User.find(5)
    @jamie = User.find(6)
    @lauren = User.find(7)
    @spencer.description = "expert"
    @jamie.description = "RD"
    @lauren.description = "Nutritionist"
    
    @post = Post.create(:id => 1, :title => "this is a tittle", :content => "this is the content")
    @post.user= @spencer
    @post.save!
    
    @comment1 = Comment.create(:id => 1, :post => @post, :content => "this is the first comment")
    @comment1.user = @jamie
    @comment1.post =@post
    @comment2 = Comment.create(:id => 2,  :post => @post, :content => "this is the second comment")
    @comment2.user = @lauren
    @comment2.post =@post
    
   
    @comment1.save!
    @comment2.save!
    @jamie.save!
    @spencer.save!
    @lauren.save!
    
  end

  def self.down
  end
end
