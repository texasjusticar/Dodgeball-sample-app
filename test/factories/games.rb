Factory.define :game do |u|
  u.sequence(:name) { |n| "Game#{n}" }
  u.kickoff Time.now
  u.scores { |t| [ Factory(:score), Factory(:score) ] }
end