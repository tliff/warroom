class AddUserId < ActiveRecord::Migration
  def self.up
    add_column :graphs, :user_id, :integer
    add_column :sources, :user_id, :integer
    add_column :secrets, :user_id, :integer
  end

  def self.down
    remove_column :secrets, :user_id
    remove_column :sources, :user_id
    remove_column :graphs, :user_id
  end
end
