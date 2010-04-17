class CreateSecrets < ActiveRecord::Migration
  def self.up
    create_table :secrets do |t|
      t.string :secret

      t.timestamps
    end
  end

  def self.down
    drop_table :secrets
  end
end
