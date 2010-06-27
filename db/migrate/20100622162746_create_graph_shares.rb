class CreateGraphShares < ActiveRecord::Migration
  def self.up
    create_table :graph_shares do |t|
      t.integer :user_id
      t.integer :graph_id
      t.string :status, :default => nil 

      t.timestamps
    end
  end

  def self.down
    drop_table :graph_shares
  end
end
