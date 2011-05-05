# this monkey patch will overcome a bug in rails that will raise an exception when doing a custom validation
# on a join model in a has_many :through - consult ticket #6217

module FalseAlarm

  def save!(options = {})
    super(options)
  rescue ActiveRecord::RecordInvalid => e
    raise e unless custom_validations.include?(e.message)
  end

  private
  
  def custom_validations
    [
      "Validation failed: games must have 2 teams",
      "Validation failed: team has a maximum of 12 players",
      "Validation failed: teams must not share the same player"
    ]
  end
end