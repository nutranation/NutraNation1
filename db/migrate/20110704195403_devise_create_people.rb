class DeviseCreatePeople < ActiveRecord::Migration
  def self.up
    
    create_table(:users) do |t|
      t.string :name
      t.string :location
      t.text :description
      
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.boolean :admin
     
      

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_column :users, :avatar_file_name,    :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size,    :integer
    add_column :users, :avatar_updated_at,   :datetime
    
    # add_index :people, :confirmation_token,   :unique => true
    # add_index :people, :unlock_token,         :unique => true
    # add_index :people, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
