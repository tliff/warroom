class CreateGraphs < ActiveRecord::Migration
  def self.up
    create_table :graphs do |t|
      t.string :name
      t.string :stack_type
      t.timestamps
    end
  end

  def self.down
    drop_table :graphs
  end
end
