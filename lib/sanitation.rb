require 'csv'
require 'pry'

module Sanitation
  attr_reader    :name,
                 :concentration,
                 :race,
                 :year,
                 :data

  def clean_up_district_data(input)
    input[:enrollment].values.each do |file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        @name = line[:location].upcase
        populate_district_data
      end
    end
  end

#change name to reflect enrollments
  def choose_destiny(file)
   populate_kindergarten_data if file.include? "Kindergartners"
   populate_high_school_data if file.include? "High school graduation"
  end

  def clean_up_enrollment_data(input)
    input[:enrollment].values.each do |file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        @name = line[:location].upcase
        #@concentration = line[:score] unless :score == nil
        #@race = line[:race_ethnicity] unless :race_ethnicity == nil   #changes made after statewide testing
        @year = line[:timeframe].to_i
        @data = line[:data][0..4].to_f
        choose_destiny(file)
      end
    end
  end

  def statewide_test_choose_destiny(file)
    #binding.pry
    populate_third_grade if file.include? "3rd"
    populate_third_grade if file.include? "8th"
    populate_third_grade if file.include? "Average"
  end

  def clean_up_statewide_test_data(input)
    input[:statewide_testing].values.each do |file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        @name = line[:location].upcase
        @concentration = line[:score]  #unless :score == nil
        @race = line[:race_ethnicity]  #unless :race_ethnicity == nil   #changes made after statewide testing
        @year = line[:timeframe].to_i
        if line[:data].nil?
            @data = "N/A"
        else
          @data = line[:data][0..4].to_f
        end
        #binding.pry
        statewide_test_choose_destiny(file)
      end
    end
  end
end
