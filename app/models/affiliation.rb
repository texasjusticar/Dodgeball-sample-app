class Affiliation < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  
  validate :validate_team_size
  
  include FalseAlarm # Rails has a bug, and this will recover it rather than exception the app
  
  private
  
  def validate_team_size
    msg = "team has a maximum of 12 players"
    errors[:base] << msg if team.players.size == Team::MAX_PLAYERS
  end
end
