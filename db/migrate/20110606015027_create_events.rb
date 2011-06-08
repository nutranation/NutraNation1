class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :time
      t.string :location
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
