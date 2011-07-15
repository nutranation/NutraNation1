class AddSeenToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :seen, :boolean
  end

  def self.down
    remove_column :messages, :seen
  end
end
