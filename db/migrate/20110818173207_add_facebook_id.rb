class AddFacebookId < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_id, :integer
  end

  def self.down
    remove_column :users, :facebook_id
  end
end
