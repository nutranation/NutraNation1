class Tag < ActiveRecord::Base
  def all_posts
    Post.joins("JOIN taggings AS t 
                ON posts.id = t.taggable_id
                  AND t.taggable_type = 'Post'").where("t.tag_id = ?", self.id )
  end
  
  def count
    Tag.joins("JOIN taggings AS t ON t.tag_id = tags.id").where("t.tag_id = ?", self.id).count
  end
  
  def display
    "#{self.name} (#{self.count})"
  end
  
 
  
  
end
