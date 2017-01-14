require 'pry'

class Enrollment
  attr_accessor :name,
                :kindergarten_participation,
                :high_school_graduation,
                :new_hash

  def initialize(input)
    @name = input[:name]
    @kindergarten_participation = input[:kindergarten_participation]
    @high_school_graduation = Hash.new(0)
  end

  def kindergarten_participation_by_year
    kindergarten_participation.each do |key, value|
      new_hash[key] = value
    end
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation[year] if year
  end

  def graduation_rate_by_year
    high_school_graduation.each do |key, value|
      new_hash[key] = value
    end
  end

  def graduation_rate_in_year(year)
    high_school_graduation[year] if year
  end
end
