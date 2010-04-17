class RenameTypeToSampleType < ActiveRecord::Migration
  def self.up
    rename_column :samples, :type, :sample_type
  end

  def self.down
    rename_column :samples, :sample_type, :type
  end
end
