class Game < ActiveRecord::Base
  has_many :scores
  has_many :teams, :through => :scores
  
  accepts_nested_attributes_for :scores
  
  validates :name, :length => {:maximum => 25}, :uniqueness => true
  validate :validate_two_teams
  validate :validate_player
  
  include FalseAlarm # Rails has a bug, and this will recover it rather than exception the app  
  
  private
  
  def validate_two_teams
    msg = "games must have 2 teams"
    # since the teams association isn't available before saving the scores attributes,
    # let's assume that one score is one team, and just make sure they're not the same team_id
    errors[:base] << msg if scores.size != 2 #or scores.map(&:team_id).uniq!.nil?
  end
  
  # this validation will make sure that a player isn't on both teams' roster
  def validate_player
    msg = "teams must not share the same player"
    errors[:base] << msg if share_player?
  end
  
  def share_player?
    @team1 = Team.find(scores.first.team_id)
    @team2 = Team.find(scores.last.team_id)
    @team1.players.each do |player|
      return true if @team2.players.include?(player)
    end
    return false
  end
end