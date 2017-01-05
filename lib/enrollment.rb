class Enrollment
  attr_reader :name,
              :kindergarten_participation

  def initialize(input)
    @name = input[:name]
    @kindergarten_participation = input[:kindergarten_participation]
  end

  def kindergarten_participation_by_year
    p @kindergarten_participation
  end

  def kindergarten_participation_in_year(year)
    values = @kindergarten_participation[year]
    values = values.round(4)
    p values
  end
end

e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
e.kindergarten_participation_in_year(2010)
#e.kindergarten_participation_by_year
