require './lib/district_repository'
require 'pry'

class HeadcountAnalyst
  def initialize(input)
    @input = input

  end

  def math(name)
    data_values = @input.districts[name].enrollment_data.values
    count = 0
    sum = data_values.reduce(0) do |sum, number|
      count += 1
      sum + number
    end
    average = sum/count
    puts average
  end

  def kindergarten_participation_rate_variation(name, against)
    #name = name
    against = :against[name]
    math(name)
    math(against)

  end

  def kindergarten_participation_rate_variation_trend(name, against)

  end
end

dr = DistrictRepository.new
dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
ha = HeadcountAnalyst.new(dr)
ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
