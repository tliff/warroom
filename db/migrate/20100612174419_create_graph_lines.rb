class CreateGraphLines < ActiveRecord::Migration
  def self.up
    create_table :graph_lines do |t|
      t.string :name
      t.integer :sortindex
      t.string :color

      t.timestamps
    end
  end

  def self.down
    drop_table :graph_lines
  end
end
