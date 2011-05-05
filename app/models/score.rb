# this is the join table between teams and games

class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
end
