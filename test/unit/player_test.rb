require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  context "a player" do
    setup do 
      @player = Factory(:player)
    end
  
    should "have a name less than 25 characters" do
      assert @player.valid?
      @bad_player = Factory.build(:player, :name=>"This name is waaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaay longer than 25 characters")
      assert @bad_player.invalid?
    end
    
    should "be allowed to have multiple teams" do
      assert_equal 0, @player.teams.size
      @team1 = Factory(:team)
      @team2 = Factory(:team)
      @team1.players << @player
      assert_equal 1, @player.teams.size
      @team2.players << @player
      assert_equal 2, @player.teams.size
    end
    
    should "have a unique name" do
      @player2 = Player.new(:name => @player.name)
      assert @player2.invalid?
    end
  
  end
end