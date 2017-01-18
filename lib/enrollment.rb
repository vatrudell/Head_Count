require 'pry'

class Enrollment
  attr_accessor :name,
                :kindergarten_participation,
                :high_school_graduation

  def initialize(input)
    @name = input[:name]
    @kindergarten_participation = input[:kindergarten_participation]
    @high_school_graduation = Hash.new(0)
  end

  def kindergarten_participation_by_year
    kindergarten_participation
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation[year] if year
  end
  #error if year doen't exists

  def graduation_rate_by_year
    high_school_graduation
  end

  def graduation_rate_in_year(year)
    high_school_graduation[year] if year
  end
  #error if year doen't exists

end
