class RenameMicropostsPost < ActiveRecord::Migration
  def self.up
    rename_table :microposts, :posts
  end

  def self.down
    rename_table :posts, :microposts
  end
end
