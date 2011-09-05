class AddParentToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :parent, :integer
  end

  def self.down
    remove_column :messages, :parent
  end
end
