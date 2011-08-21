class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, :user_id
  end

  def self.down
    drop_table :posts
  end
end
