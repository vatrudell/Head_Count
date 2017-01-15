require_relative '../lib/district_repository'
require 'pry'

class HeadcountAnalyst
  attr_accessor :database
  def initialize(input)
    @database = input
  end

  def kindergarten_participation_rate_variation(name, against)
    compare = against.values[0]
    one = database.enrollment_repository.enrollments[name].kindergarten_participation.values
    two = database.enrollment_repository.enrollments[compare].kindergarten_participation.values
    math(one, two)
    #average(one,two)
  end

  def kindergarten_participation_rate_variation_trend(name, compare)
    name_data = database.enrollment_repository.enrollments[name].kindergarten_participation
    against_data = database.enrollment_repository.enrollments[compare[:against]].kindergarten_participation
    set_year_to_data_in_new_hash(name_data, against_data)
  end

  def set_year_to_data_in_new_hash(name_data, against_data)
    final = {}
    final_hash = name_data.each_pair do |year, data|
      total = (data/against_data[year]).round(3)
      final[year] = total
    end
    final.sort_by {|year, key| year}.to_h
    # binding.pry
    # final_hash = {}
    # final.each do |year, data|
    #   final_hash[year.sort] = data
    # end
    #sorted_final = {}
    #final.sort_by {|year, data| sorted_final[year]}

      # if data != 0 && against_data[year] != 0
      #   final[year] = (name_data[year]*1000)/(against_data[year]*1000)
      # else
      #   final[year] = "N/A"
      # end
    #sort_hash(final)
  end

  # def sort_hash(final)
  #   #final =
  #   # final_hash = {}
  #   # final.each do |year, data|
  #   #   final_hash[year.sort] = data.round(3)
  #   # end
  #   # final_hash
  # end

  def kindergarten_participation_against_high_school_graduation(district)
    one = database.enrollment_repository.enrollments[district].kindergarten_participation.values
    two = database.enrollment_repository.enrollments[district].high_school_graduation.values
    math(one, two)
  end
  #
  # def kindergarten_participation_correlates_with_high_school_graduation(comparing_district)
  #   if comparing_district[:for] == "STATEWIDE"
  #     state_wide_correlation = []
  #     districts_to_run = database.districts.keys
  #     districts_to_run.delete("COLORADO")
  #     districts_to_run.each do |district|
  #       kindergarten_average = math(database.districts[district].enrollment.values)
  #       highschool_average = math(database.districts[district].graduation_data.values)
  #       state_wide_correlation << ((kindergarten_average*1000)/(highschool_average*1000)).round(3)
  #       @true_false_correlation = state_wide_correlation.map do |correlation|
  #         if  correlation > 0.6 && correlation < 1.5
  #           correlation = true
  #         else
  #           false
  #         end
  #       end
  #     end
  #     correlation_true_count = @true_false_correlation.count do |correlation|
  #       correlation == true
  #     end
  #       if correlation_true_count.to_f >= (@true_false_correlation.count * 0.7)
  #        true
  #       else
  #        false
  #       end
  #   elsif comparing_district[:for] != "STATEWIDE" && comparing_district[:for].class == String
  #     kindergarten_average = math(database.districts[comparing_district[:for]].enrollment.values)
  #     highschool_average = math(database.districts[comparing_district[:for]].graduation_data.values)
  #     result = ((kindergarten_average*1000)/(highschool_average*1000)).round(3)
  #     if  result > 0.6 && result < 1.5
  #       true
  #     else
  #       false
  #     end
  #   elsif comparing_district[:across].class == Array #maybe put :across in this logic for refactoring
  #     district_averages = comparing_district[:across].map do |district|
  #       kindergarten_average = math(inexput.districts[district].enrollment.values)
  #       highschool_average = math(database.districts[district].graduation_data.values)
  #       district_averages = ((kindergarten_average*1000)/(highschool_average*1000)).round(3)
  #     end
  #     true_false_count = district_averages.count do |correlation|
  #       correlation > 0.6 && correlation < 1.5
  #     end
  #     if true_false_count > comparing_district[:across].count * 0.7
  #       true
  #     else
  #       false
  #     end
  #   end
  # end

  def math(number_1, number_2)
     total_1 = number_1.reduce(:+)
     total_2 = number_2.reduce(:+)
     grand_total = (total_1/number_1.length)/(total_2/number_2.length)
     grand_total.round(3)
  end

  # def average(number_1, number_2)
  #   numbers = [number_1, number_2]
  #   total_1 = number_1.reduce(:+)
  #   total_2 = number_2.reduce(:+)
  #   divide_totals(total_1, total_2, numbers)
  # end
  #
  # def divide_totals(total_1, total_2, numbers = nil)
  #   grand_total = (total_1/numbers[0].length)/(total_2/numbers[1].length)
  #   grand_total.round(3)
  # end
end
