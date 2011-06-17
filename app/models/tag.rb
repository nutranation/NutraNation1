class Tag < ActiveRecord::Base
  def all_posts
    Post.joins("JOIN taggings AS t 
                ON posts.id = t.taggable_id
                  AND t.taggable_type = 'Post'").where("t.tag_id = ?", self.id )
  end
  
  
end
