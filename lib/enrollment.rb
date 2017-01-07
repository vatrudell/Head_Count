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
      new_hash[key] = value.to_s[0..4].to_f
    end
    p new_hash
  end
  ## revisit "truncate" method or class?

  def kindergarten_participation_in_year(year)
    @kindergarten_participation[year.to_s].to_s[0..4].to_f
    #binding.pry
  end
end

# e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
# e.kindergarten_participation_in_year(2010)
# e.kindergarten_participation_by_year
