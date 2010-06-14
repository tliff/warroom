class RemoveSampleTypeUnitFromSamples < ActiveRecord::Migration
  def self.up
    remove_column :samples, :sample_type
    remove_column :samples, :unit
  end

  def self.down
    add_column :samples, :unit, :string
    add_column :samples, :sample_type, :string
  end
end
