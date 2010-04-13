class AddAtoms < ActiveRecord::Migration
  def self.up
    remove_column :samples, :value
    add_column :samples, :text, :string
    add_column :samples, :identifier, :string
    rename_column :samples, :source_id, :sample_id
    remove_timestamps :samples
    rename_table :samples, :atoms
    create_table :samples, :force => true do |t|
      t.integer :source_id
      t.timestamps
    end
  end

  def self.down
    add_timestamps :samples
    rename_column :samples, :sample_id, :source_id
    drop_table :samples
    rename_table :atoms, :samples
    remove_column :samples, :identifier
    remove_column :samples, :text
    add_column :samples, :value, :text
  end
end
