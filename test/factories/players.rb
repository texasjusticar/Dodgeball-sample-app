Factory.define :player do |u|
  u.sequence(:name) { |n| "Player#{n}" }
end