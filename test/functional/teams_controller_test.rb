require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  
  setup do
    @team = Factory(:team)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team" do
    post :create, :team => {:name => "Awesome Team"}
    assert @new_team = Team.find_by_name("Awesome Team")

    assert_redirected_to team_path(@new_team.id)
  end

  test "should show team" do
    get :show, :id => @team.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team.to_param
    assert_response :success
  end

  test "should update team" do
    put :update, :id => @team.to_param, :team => @team.attributes
    assert_redirected_to team_path(assigns(:team))
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete :destroy, :id => @team.to_param
    end

    assert_redirected_to teams_path
  end
  
  test "should add a player to a team" do
    @player = Factory(:player)
    post :add_player, :id => @team.to_param, :new_player_id => @player.id, :format => "js"
    assert_response :success
  end
  
  test "should remove a player from a team" do
    @team.players << Factory(:player)
    post :remove_player, :id => @team.to_param, :player_id => @team.players.first.id, :format => "js"
    assert_response :success
  end
end
