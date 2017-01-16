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
        @year = line[:timeframe].to_i
        @data = line[:data][0..4].to_f
        choose_destiny(file)
      end
    end
  end

  def statewide_test_choose_destiny(file)
    populate_third_grade if file.include? "3rd"
    populate_eighth_grade if file.include? "8th"
    populate_average_proficiency if file.include? "Average"
  end

  def clean_up_statewide_data(input)
    input[:statewide_testing].values.each do |file|
    opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
      @name = line[:location].upcase
      statewide_data_cleaner(line[:data])
      #subject = line[:score]
      statewide_concentration_cleaner(file, line[:score])
      #now wont go into third and eigth because there is no
      statewide_race_data_cleaner(line[:race_ethnicity]) unless line[
      :race_ethnicity].nil?
      @year = line[:timeframe].to_i
      statewide_test_choose_destiny(file)
      end
    end
  end

  def statewide_data_cleaner(line_data)
    if line_data.nil?
      @data =  "N/A"
    else
      @data =  (line_data[0..4].to_f)
    end
  end

  def statewide_concentration_cleaner(file, score = nil)
    if file.include? "Math"
      @concentration = :math
    elsif file.include? "Reading"
      @concentration = :reading
    elsif file.include? "Writing"
      @concentration = :writing
    else
      @concentration = "Derp"       #score.downcase.to_sym
      #binding.pry
    end
  end

  def statewide_race_data_cleaner(race_ethnicity)
    @race = race_ethnicity.downcase.tr(" ", "_").to_sym
    if race_ethnicity.end_with?("Islander")
      @race = :pacific_islander
    end
  end
end
