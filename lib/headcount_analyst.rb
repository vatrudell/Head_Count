require './lib/district_repository'
require 'pry'

class HeadcountAnalyst
  def initialize(input)
    @input = input

  end

  def math(district)
    #binding.pry
    data_values = @input.districts[district].enrollment_data.values
    count = 0
    sum = data_values.reduce(0) do |sum, number|
      # if number > 0.to_f
        count += 1
        sum + number
      #
    #end
    end
    average = sum/count
    average
  end

  def kindergarten_participation_rate_variation(name, against)
    #name = name
    compare = against.values[0]
    one = math(name)
    two = math(compare)


    result = (one*1000)/(two*1000)
    result.round(3)
    #binding.pry

  end

  def kindergarten_participation_rate_variation_trend(name, compare)
    name_data = @input.districts[name].enrollment_data
    against = compare[:against]
    against_data = @input.districts[against].enrollment_data
    final = Hash.new(0)

    name_data.each do |year, data|
      if data != 0 && against_data[year] != 0
        final[year] = (name_data[year]*1000)/(against_data[year]*1000)
      else
        final[year] = "N/A"
      end
    end

    final = final.sort_by {|year, data| year}
    final_hash = {}
    final.each do |year, data|
      final_hash[year] = data.to_s[0..4].to_f
    end
    final_hash
  end
end

# dr = DistrictRepository.new
# dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
# ha = HeadcountAnalyst.new(dr)
# ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
