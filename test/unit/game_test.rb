require 'test_helper'

class GameTest < ActiveSupport::TestCase

  context "a game" do
    
    setup do
      @game = Factory(:game)
    end
    
    should "have a name less that 25 characters" do
      assert @game.valid?
      @bad_game = Factory.build(:game, :name=>"This name is waaaaaaaaaaaaaaaaaaaay longer than 25 characters")
      assert @bad_game.invalid?
    end
    
    should "have a unique name" do
      @game2 = Factory.build(:game, :name => @game.name)
      assert @game2.invalid?
    end
  
    should "have exactly 2 teams" do
      assert @game.valid?
      @game.teams << Team.new(:name => "Team3")
      assert @game.invalid?
    end
    
    should "not allow a game to take place where a player is on both teams" do
      @free_agent = Factory(:player)
      @game.teams.first.players << @free_agent
      @game.teams.last.players << @free_agent
      assert @game.invalid?
    end
  
  end

end
