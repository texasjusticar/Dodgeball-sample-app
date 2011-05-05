require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = Factory(:game)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    @team1 = Factory(:team)
    @team2 = Factory(:team)
    post :create, :game => {"name" => "Awesome Game",
      "scores_attributes" => {
          "0" => {"team_id" => @team1.id.to_s, "score" => 1},
          "1" => {"team_id" => @team2.id.to_s, "score" => 3}
        }
      }
    assert @new_game = Game.find_by_name("Awesome Game")

    assert_redirected_to game_path(@new_game.id)
  end

  test "should show game" do
    get :show, :id => @game.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @game.to_param
    assert_response :success
  end

  test "should update game" do
    put :update, :id => @game.to_param, :game => @game.attributes
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, :id => @game.to_param
    end

    assert_redirected_to games_path
  end
end
