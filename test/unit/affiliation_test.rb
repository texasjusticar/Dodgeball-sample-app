require 'test_helper'

class AffiliationTest < ActiveSupport::TestCase

  context "an affiliate relationship" do
    should "validate the maximum players for a team" do
      @team = Factory(:team)
      create_team(@team)
      assert_equal Team::MAX_PLAYERS,@team.players.size
      @team.affiliations.last.send(:validate_team_size)
      assert_equal 0, @team.errors[:base].size
      @new_player = Factory(:player)
      @recruit = Affiliation.new(:team_id => @team.id, :player_id => @new_player.id)
      @recruit.send(:validate_team_size)
      assert_equal 1, @recruit.errors[:base].size
    end
  end

end
