class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string  :name, :null => false 
      t.datetime :kickoff
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
