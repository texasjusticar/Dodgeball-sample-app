Factory.define :team do |u|
  u.sequence(:name) { |n| "Team#{n}" }
end