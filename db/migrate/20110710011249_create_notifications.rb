class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :item_type
      t.boolean :seen
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
