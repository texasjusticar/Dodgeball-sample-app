class Player < ActiveRecord::Base
  has_many :teams, :through => :affiliations
  has_many :affiliations
    
  validates :name, :length => {:maximum => 25}, :uniqueness => true

end
