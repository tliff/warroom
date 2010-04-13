class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.integer :source_id
      t.text :value

      t.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
