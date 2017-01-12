require_relative 'district_repository'
require 'pry'

class HeadcountAnalyst
  attr_accessor :input
  def initialize(input)
    @input = input
  end

  def kindergarten_participation_rate_variation(name, against)
    compare = against.values[0]
    one = math(input.districts[name].enrollment_data.values)
    two = math(input.districts[compare].graduation_data.values)
    result = (one*1000)/(two*1000)
    result.round(3)
  end

  def kindergarten_participation_rate_variation_trend(name, compare)
    name_data = input.districts[name].enrollment_data
    against = compare[:against]
    against_data = input.districts[against].enrollment_data
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
    final.each {|year, data| final_hash[year] = data.to_s[0..4].to_f}
    final_hash
  end

  def kindergarten_participation_against_high_school_graduation(district)
    one = math(input.districts[district].enrollment_data.values)
    two = math(input.districts[district].graduation_data.values)
    result = (one*1000)/(two*1000)
    result.round(3)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(comparing_district)
    if comparing_district[:for] == "STATEWIDE"
      state_wide_correlation = []
      districts_to_run = input.districts.keys
      districts_to_run.delete("COLORADO")
      districts_to_run.each do |district|
        kindergarten_average = math(input.districts[district].enrollment_data.values)
        highschool_average = math(input.districts[district].graduation_data.values)
        state_wide_correlation << ((kindergarten_average*1000)/(highschool_average*1000)).round(3)
        @true_false_correlation = state_wide_correlation.map do |correlation|
          if  correlation > 0.6 && correlation < 1.5
            correlation = true
          else
            false
          end
        end
      end
      correlation_true_count = @true_false_correlation.count do |correlation|
        correlation == true
      end
        if correlation_true_count.to_f >= (@true_false_correlation.count * 0.7)
          puts true
        else
          puts false
        end
    elsif comparing_district[:for] != "STATEWIDE" && comparing_district[:for].class == String
      kindergarten_average = math(input.districts[comparing_district[:for]].enrollment_data.values)
      highschool_average = math(input.districts[comparing_district[:for]].graduation_data.values)
      result = ((kindergarten_average*1000)/(highschool_average*1000)).round(3)
      if  result > 0.6 && result < 1.5
        true
      else
        false
      end
    elsif comparing_district[:across].class == Array #maybe put :across in this logic for refactoring
      district_averages = comparing_district[:across].map do |district|
        kindergarten_average = math(inexput.districts[district].enrollment_data.values)
        highschool_average = math(input.districts[district].graduation_data.values)
        district_averages = ((kindergarten_average*1000)/(highschool_average*1000)).round(3)
      end
      true_false_count = district_averages.count do |correlation|
        correlation > 0.6 && correlation < 1.5
      end
      if true_false_count > comparing_district[:across].count * 0.7
        true
      else
        false
      end
    end
  end

  def math(district)
    count = 0
    sum = district.reduce(0) do |sum, number|
      count += 1
      sum + number
    end
    average = sum/count
  end
end