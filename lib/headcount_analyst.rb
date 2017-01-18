require_relative '../lib/district_repository'
require 'pry'

class HeadcountAnalyst
  attr_accessor :database,
                :growths
  def initialize(input)
    @database = input
  end

  def kindergarten_participation_rate_variation(name, against)
    compare = against.values[0]
    one = database.enrollment_repository.enrollments[name].kindergarten_participation.values
    two = database.enrollment_repository.enrollments[compare].kindergarten_participation.values
    math(one, two)
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
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten = database.enrollment_repository.enrollments[district].kindergarten_participation.values
    colorado_one = database.enrollment_repository.enrollments["COLORADO"].kindergarten_participation.values
    graduation = database.enrollment_repository.enrollments[district].high_school_graduation.values
    colorado_two = database.enrollment_repository.enrollments["COLORADO"].high_school_graduation.values
    ((math(kindergarten, colorado_one))/(math(graduation, colorado_two))).round(3)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(comparing_district)
    if comparing_district[:for] == "STATEWIDE"
      statewide_correlation_setup(comparing_district)
     elsif comparing_district.values != "STATEWIDE" && comparing_district.values.count == 1
      single_district_correlation(comparing_district[:for])
    elsif comparing_district[:across].class == Array
      multiple_district_correlation(comparing_district)
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
    single_ratio << kindergarten_participation_against_high_school_graduation(district)
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

  def top_statewide_test_year_over_year_growth(parameters)
    # binding.pry
    # raise(UnknownDataError) if ![3, 8].include?(settings[:grade])
    # raise(InsufficientInformationError) if settings[:grade].nil?
    if parameters[:grade] == 3 && parameters[:weighting].nil? && parameters[:subject] != nil
      top_growth_grade_three(parameters)
    elsif parameters[:grade] == 8 && parameters[:weighting].nil? && parameters[:subject] != nil
      top_growth_grade_eight(parameters)
    elsif parameters[:subject].nil? && parameters[:grade] == 8
      all_district_averages_grade_eight(parameters)
    elsif parameters[:subject].nil? && parameters[:grade] == 3
      all_district_averages_grade_three(parameters)
    end
  end

  def top_growth_grade_eight(parameters)
    subject = parameters[:subject]
    @growths= Hash.new(0)
    @database.statewide_test_repository.statewide_information.keys.each do |district|
      find_all_years_grade_eight(subject, district)
      find_data_grade_eight(subject, district)
      set_growths(district)
    end
    sort_growths(parameters)
  end
  
  def set_growths(district)
    if @first_year.nil? || (@last_year == @first_year)
      growths[district] = 0
    else
      average_growth = ((@data_two - @data_one)/(@last_year - @first_year)).round(3)
      growths[district] = average_growth
    end
  end 

  def sort_growths(parameters)
    top_growths = growths.sort_by do |district, growths|
      growths
    end
    if parameters[:top].nil?
      top_growths.last
    else
      top_growths.reverse[0..(parameters[:top]-1)]  
    end
  end

  def find_all_years_grade_eight(subject, district)
    years = @database.statewide_test_repository.statewide_information[district].grade_eight_proficient.keys
    correct_years = years.find_all do |year|
      @database.statewide_test_repository.statewide_information[district].grade_eight_proficient[year].keys.include?(subject) && (@database.statewide_test_repository.statewide_information[district].grade_eight_proficient[year][subject] < 1 && @database.statewide_test_repository.statewide_information[district].grade_eight_proficient[year][subject] > 0)
    end
    @first_year = correct_years.first
    @last_year = correct_years.last
  end

  def find_data_grade_eight(subject, district)
    unless @first_year.nil? || (@last_year == @first_year)
      @data_one = @database.statewide_test_repository.statewide_information[district].grade_eight_proficient[@first_year][subject]
      @data_two = @database.statewide_test_repository.statewide_information[district].grade_eight_proficient[@last_year][subject]
    end
  end

  def top_growth_grade_three(parameters)
    subject = parameters[:subject]
    @growths= Hash.new(0)
    @database.statewide_test_repository.statewide_information.keys.each do |district|
      find_all_years_grade_three(subject, district)
      find_data_grade_three(subject, district)
      set_growths(district)
    end
    sort_growths(parameters)
  end

  def find_all_years_grade_three(subject, district)
    years = @database.statewide_test_repository.statewide_information[district].grade_three_proficient.keys
    correct_years = years.find_all do |year|
      @database.statewide_test_repository.statewide_information[district].grade_three_proficient[year].keys.include?(subject) &&
      (@database.statewide_test_repository.statewide_information[district].grade_three_proficient[year][subject] < 1 &&
      @database.statewide_test_repository.statewide_information[district].grade_three_proficient[year][subject] > 0)
    end
    @first_year = correct_years.first
    @last_year = correct_years.last
  end

  def find_data_grade_three(subject, district)
    unless @first_year.nil? || (@last_year == @first_year)
      @data_one = @database.statewide_test_repository.statewide_information[district].grade_three_proficient[@first_year][subject]
      @data_two = @database.statewide_test_repository.statewide_information[district].grade_three_proficient[@last_year][subject]
    end
  end

  def all_district_averages_grade_eight(parameters)
    
    top_growth_grade_eight(grade: 8, subject: :math)
    math = @growths
    top_growth_grade_eight(grade: 8, subject: :reading)
    reading = @growths
    top_growth_grade_eight(grade: 8, subject: :writing)
    writing = @growths
    calculation_brain(math, reading, writing, parameters)
  end

  def all_district_averages_grade_three(parameters)
    top_growth_grade_three(grade: 3, subject: :math)
    math = @growths
    top_growth_grade_three(grade: 3, subject: :reading)
    reading = @growths
    top_growth_grade_three(grade: 3, subject: :writing)
    writing = @growths
    calculation_brain(math, reading, writing, parameters)
  end

  def calculation_brain(math, reading, writing, parameters)
    if parameters[:weighting].nil?
      all_district_averages_calculation(math,reading,writing)
    else
      weighted_calculation(math, reading, writing, parameters)
    end
  end

  def all_district_averages_calculation(math,reading,writing)
    all_district_averages_all = Hash.new
    districts = writing.keys
    districts.each do |district|
      all_district_averages_all[district] = ((writing[district] + reading[district] + math[district])/3).round(3)
    end
    district_sorting(all_district_averages_all)
  end

  def weighted_calculation(math, reading, writing, parameters)
    math_weight = parameters[:weighting][:math]
    reading_weight = parameters[:weighting][:reading]
    writing_weight = parameters[:weighting][:writing]
    all_district_averages_all = Hash.new
    districts = writing.keys
    districts.each do |district|
      all_district_averages_all[district] = ((writing[district] * writing_weight) + (reading[district] * reading_weight) + (math[district] * math_weight)).round(3)
    end
    district_sorting(all_district_averages_all)
  end
  
  def district_sorting(averages)
    final = averages.sort_by {|district, growth| growth}
      final.reverse[0]
  end
end



dr = DistrictRepository.new
    dr.load_data({:enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv",
                   },
                   :statewide_testing => {
                     :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                     :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                     :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    ha.kindergarten_participation_against_high_school_graduation("COLORADO")
    ha.kindergarten_participation_correlates_with_high_school_graduation(:for =>'STATEWIDE')
    ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
    # ha.test_methods
    # top_statewide_test_year_over_year_growth(2000)
    # ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math, top: 3)
    # ha.all_district_averages_grade_three
    # ha.top_statewide_test_year_over_year_growth(grade: 8, :weighting => {:math => 0.5, :reading => 0.5, :writing => 0.0})
    # ha.test_methods
     ha.top_statewide_test_year_over_year_growth(grade: 3)
    #ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'MONTROSE COUNTY RE-1J')
    #ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ACADEMY 20", 'PARK (ESTES PARK) R-3', 'YUMA SCHOOL DISTRICT 1'])

