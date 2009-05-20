class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :username
      t.string  :favorite_language
      t.integer :lock_version, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
