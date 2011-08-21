class AddTitletoPost < ActiveRecord::Migration
  def self.up
   # rename_column :posts, :content, :title
   # add_column :posts, :content, :text
  end

  def self.down
    #rename_column :posts, :title, :content
    #remove_column :posts, :content
  end
end
