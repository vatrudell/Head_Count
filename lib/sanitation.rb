require 'csv'
require 'pry'

module Sanitation
  attr_reader    :name,
                 :concentration,
                 :race,
                 :year,
                 :data

  def choose_destiny(file)
   populate_kindergarten_data if file.include?("Kindergartners")
   populate_high_school_data if file.include?("High school graduation")
  end

  def clean_up_enrollment_data(input)
    input[:enrollment].values.each do |file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        @name = line[:location].upcase
        @concentration = line[:score] unless :score == nil
        @race = line[:race_ethnicity] unless :race_ethnicity == nil
        @year = line[:timeframe].to_i
        @data = line[:data][0..4].to_f
        choose_destiny(file)
      end
    end
  end

  def clean_up_district_data(input)
    input[:enrollment].values.each do |file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        @name = line[:location].upcase
        populate_district_data
      end
    end
  end
end
