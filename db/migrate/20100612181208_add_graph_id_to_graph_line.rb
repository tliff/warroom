class AddGraphIdToGraphLine < ActiveRecord::Migration
  def self.up
    add_column :graph_lines, :graph_id, :integer
  end

  def self.down
    remove_column :graph_lines, :graph_id
  end
end
