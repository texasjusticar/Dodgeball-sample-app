module TeamsHelper
  
  def available_options_for_team(team)
    options_for_select(team.available_players.collect {|p| [ p.name, p.id ] })
  end
  
end
