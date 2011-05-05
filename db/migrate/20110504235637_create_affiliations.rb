class CreateAffiliations < ActiveRecord::Migration
  def self.up
    create_table :affiliations do |t|
      t.integer :team_id, :player_id
      t.timestamps
    end
    
    add_index :affiliations, [:team_id, :player_id], :unique => true
  end

  def self.down
    drop_table :affiliations
  end
end
