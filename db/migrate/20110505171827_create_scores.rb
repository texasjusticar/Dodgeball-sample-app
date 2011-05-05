class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer :team_id, :game_id, :score
      t.timestamps
    end
    add_index :scores, [:team_id, :game_id], :unique => true
  end

  def self.down
    drop_table :scores
  end
end
