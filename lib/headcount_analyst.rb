require_relative '../lib/district_repository'
require 'pry'

class HeadcountAnalyst
  attr_accessor :database
  def initialize(input)
    @database = input
  end

  def kindergarten_participation_rate_variation(name, against)
    compare = against.values[0]
    one = database.enrollment_repository.enrollments[name].
    kindergarten_participation.values
    two = database.enrollment_repository.enrollments[compare].
    kindergarten_participation.values
    math(one, two)
  end

  def kindergarten_participation_rate_variation_trend(name, compare)
    name_data = database.enrollment_repository.enrollments[name].
    kindergarten_participation
    against_data = database.enrollment_repository.enrollments[compare[
      :against]].kindergarten_participation
    set_year_to_data_in_new_hash(name_data, against_data)
  end

  def set_year_to_data_in_new_hash(name_data, against_data)
    final = {}
    final_hash = name_data.each_pair do |year, data|
      total = (data/against_data[year]).round(3)
      final[year] = total
    end
    final.sort_by {|year, key| year}.to_h
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten = database.enrollment_repository.enrollments[district].
    kindergarten_participation.values
    colorado_one = database.enrollment_repository.enrollments["COLORADO"].
    kindergarten_participation.values
    graduation = database.enrollment_repository.enrollments[district].
    high_school_graduation.values
    colorado_two = database.enrollment_repository.enrollments["COLORADO"].
    high_school_graduation.values
    kindergarten_variation = math(kindergarten, colorado_one)
    graduation_variation = math(graduation, colorado_two)
    (kindergarten_variation/graduation_variation).round(3)
  end


#make smaller line 52
  def kindergarten_participation_correlates_with_high_school_graduation(compare)
    if compare[:for] == "STATEWIDE"
      statewide_correlation_setup(compare)
    elsif compare.values != "STATEWIDE" && compare.
       values.count == 1
      single_district_correlation(compare[:for])
    elsif compare[:across].class == Array
      multiple_district_correlation(compare)
    end
  end

  def check_if_within_ratio(ratios)
    passing = ratios.count do |ratio|
      ratio > 0.6 && ratio <1.5
    end
      if passing > (ratios.count*0.7)
        true
      else
        false
      end
  end

  def statewide_correlation_setup(statewide_districts)
    districts_to_run = database.enrollment_repository.enrollments.keys
    districts_to_run.delete("COLORADO")
    state_wide_correlation = districts_to_run.map do |district|
      kindergarten_participation_against_high_school_graduation(district)
    end
      check_if_within_ratio(state_wide_correlation)
  end

  def single_district_correlation(district)
    single_ratio = []
    result = kindergarten_participation_against_high_school_graduation(district)
    single_ratio << result
    check_if_within_ratio(single_ratio)
  end

  def multiple_district_correlation(districts)
    districts_correlations = districts[:across].map do |district|
      kindergarten_participation_against_high_school_graduation(district)
    end
    check_if_within_ratio(districts_correlations)
  end

  def math(number_1, number_2)
     total_1 = number_1.reduce(:+)
     total_2 = number_2.reduce(:+)
     grand_total = (total_1/number_1.length)/(total_2/number_2.length)
     grand_total.round(3)
  end

  def top_statewide_test_year_over_year_growth(year)
  end
end
