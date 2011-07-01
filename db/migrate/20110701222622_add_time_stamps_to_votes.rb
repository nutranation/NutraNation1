class AddTimeStampsToVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :user_id
      t.integer :content_id
      t.string :content_type
      t.integer :value
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
