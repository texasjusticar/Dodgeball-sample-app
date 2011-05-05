class Team < ActiveRecord::Base
  has_many :players, :through => :affiliations
  has_many :affiliations
  has_many :games, :through => :scores
  has_many :scores
  
  MAX_PLAYERS = 12
  MIN_PLAYERS = 8
  
  validates :name, :length => {:maximum => 25}, :uniqueness => true

  def eligible?
    !ineligible?
  end
  
  def ineligible?
    players.size < MIN_PLAYERS
  end
  
  def new_player_id=(player_id)
    raise ArgumentError unless player = Player.find(player_id)
    players << player
  end
  
  def available_players
    return Player.all if players.empty?
    Player.where("id not in (#{players.map(&:id).join(",")})")
  end

end
