class AddSourceIdToGraphLine < ActiveRecord::Migration
  def self.up
    add_column :graph_lines, :source_id, :integer
  end

  def self.down
    remove_column :graph_lines, :source_id
  end
end
