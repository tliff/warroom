class GenerateSamples < ActiveRecord::Migration
  def self.up
    drop_table :atoms
    drop_table :samples
    create_table :samples, :force => true do |t|
      t.integer "source_id"
      t.float "value"
      t.string "type"
      t.string "unit"
      t.datetime "sampled_at"
      t.timestamps
    end
  end

  def self.down
    drop_table :samples
    create_table "samples", :force => true do |t|
      t.integer  "source_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "atoms", :force => true do |t|
      t.integer "sample_id"
      t.string  "text"
      t.string  "identifier"
    end
    
  end
end
