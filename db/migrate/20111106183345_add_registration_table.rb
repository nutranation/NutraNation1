class AddRegistrationTable < ActiveRecord::Migration
  def self.up
    create_table :waiting do |t|
      t.string :email
    end
    add_index :waiting, :email, :unique => true
  end

  def self.down
    drop_table :waiting
  end
end
