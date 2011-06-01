class AddDescriptiontoUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :description, :text
    change_column :posts, :title, :text
  end

  def self.down
    remove_column :users, :description
    change_column :posts, :title, :string
  end
end
