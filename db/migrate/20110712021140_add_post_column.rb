class AddPostColumn < ActiveRecord::Migration
  def self.up
    add_column :notifications, :creator, :integer
  end

  def self.down
    remove_column :notifications, :creator
  end
end
