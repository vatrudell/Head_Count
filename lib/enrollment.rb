require 'pry'

class Enrollment
  attr_accessor :name,
                :kindergarten_participation,
                :high_school_graduation
                # :data_tag

  def initialize(input)
    @name = input[:name]
    #binding.pry
    @kindergarten_participation = input[:kindergarten_participation]
    @high_school_graduation = Hash.new(0)
    # @data_tag = data_tag
  end

  def kindergarten_participation_by_year
    new_hash = {}
    @kindergarten_participation.each do |key, value| 
      key.to_i
      new_hash[key] = value
    end
    new_hash
  end
  ## revisit "truncate" method or class?

  def kindergarten_participation_in_year(year)
    if year
    @kindergarten_participation[year]
    #binding.pry
  end

  def graduation_rate_by_year
    new_hash = {}
    @high_school_graduation.each do |key, value|
      key.to_i
      new_hash[key] = value
    end
    new_hash
  end

  def graduation_rate_in_year(year)
    @high_school_graduation[year]
  end
end
