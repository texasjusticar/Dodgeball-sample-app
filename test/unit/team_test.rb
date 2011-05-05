require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  
  context "a team" do
    
    setup do
      @team = Factory(:team)
    end
  
    should "have 12 players maximum" do
      create_team(@team,13)
      assert_equal Team::MAX_PLAYERS,@team.players.size
    end
    
    should "have #{Team::MIN_PLAYERS} players minimum to be eligible for games" do
      (Team::MIN_PLAYERS.to_i - 1).times do
        @team.players << Factory(:player)
      end
      assert @team.ineligible?
      @team.players << Factory(:player)
      assert @team.eligible?
    end
    
    should "have a name less that 25 characters" do
      assert @team.valid?
      @bad_team = Factory.build(:player,:name=>"This name is waaaaaaaaaaaaaaaaaaaay longer than 25 characters")
      assert @bad_team.invalid?
    end
    
    should "have a unique name" do
      @team2 = Team.new(:name => @team.name)
      assert @team2.invalid?
    end
  
    should "add a player to the roster" do
      @player = Factory(:player)
      assert !@team.players.include?(@player)
      @team.new_player_id = @player.id
      @team.save!
      assert @team.reload.players.include?(@player)
    end
    
    should "list all available players that are not currently on the roster" do

      # make a quick team roster
      (Team::MIN_PLAYERS.to_i).times do
        @team.players << Factory(:player)
      end

      create_players

      assert_equal 16, Player.all.size
      @available_players = @team.available_players
      assert_equal 8,@available_players.size
      assert_equal 8,@team.players.size
      assert (not @available_players.include? @team.players.first)
      assert (not @available_players.include? @team.players.last)
    end
    
    should "list all players as available if the roster is empty" do
      create_players
      assert_equal 0,@team.players.size
      assert_equal Team::MIN_PLAYERS.to_i,@team.available_players.size
    end
  end
end
