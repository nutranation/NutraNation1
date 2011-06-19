class Updaterelationshipindex < ActiveRecord::Migration
  def self.up
    remove_index(:relationships, [:follower_id, :followed_id])
    add_index :relationships, [:follower_id, :followed_id, :item_type], :unique => true,  :name => "following_index"
  end

  def self.down
    add_index :relationships, [:follower_id, :followed_id], :unique => true
  end
end
