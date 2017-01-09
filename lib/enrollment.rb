require 'pry'

class Enrollment
  attr_accessor :name,
                :kindergarten_participation

  def initialize(input)
    @name = input[:name]
    #binding.pry
    @kindergarten_participation = input[:kindergarten_participation]
  end

  def kindergarten_participation_by_year
    new_hash = {}
    @kindergarten_participation.each do |key, value|  #
      key.to_i
      new_hash[key] = value
    end
    new_hash
  end
  ## revisit "truncate" method or class?

  def kindergarten_participation_in_year(year)
    @kindergarten_participation[year]
    #binding.pry
  end
end
