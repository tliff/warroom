class AddIndexToSamplesOnSampledAt < ActiveRecord::Migration
  def self.up
    add_index :samples, :sampled_at
  end

  def self.down
    remove_index :samples, :sampled_at
  end
end
