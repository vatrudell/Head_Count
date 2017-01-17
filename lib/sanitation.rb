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

  def clean_up_statewide_data(input)
    input[:statewide_testing].each do |name, file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        statewide_csv_brain(line, name, file)
      end
    end
  end

  def statewide_csv_brain(line, name, file)
    @district_name = line[:location].upcase
    @year = line[:timeframe].to_i
    statewide_concentration_cleaner(line[:score])
    statewide_data_cleaner(line[:data])
    statewide_race_renaming(line[:race_ethnicity])
      choose_statewide_destiny(name, file)
  end

  def statewide_data_cleaner(line_data)
    if line_data == "N/A"
      @district_data = 0
    elsif line_data.nil?
      @district_data =  0
    else
      @district_data =  (line_data[0..4].to_f)
    end
  end

  def statewide_race_renaming(line_race)
    @race = :all_students if line_race == "All Students"
    @race = :asian if line_race == "Asian"
    @race = :black if line_race == "Black"
    @race = :pacific_islander if line_race == "Hawaiian/Pacific Islander"
    @race = :hispanic if line_race == "Hispanic"
    @race = :native_american if line_race == "Native American"
    @race = :two_or_more if line_race == "Two or more"
    @race = :white if line_race == "White"
  end

  def statewide_concentration_cleaner(line_concentration)
    @concentration = :math if line_concentration == "Math"
    @concentration = :writing if line_concentration == "Writing"
    @concentration = :reading if line_concentration == "Reading"
  end
  
  def choose_statewide_destiny(name, opened_file)
    populate_third_grade(name) if name == :third_grade
    populate_eighth_grade(name) if name == :eighth_grade
    populate_average_proficiency(name) if name == :math
    populate_average_proficiency(name) if name == :reading
    populate_average_proficiency(name) if name == :writing
  end

  def clean_up_economic_data(input)
    input[:economic_profile].values.each do |file|
    opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      opened_file.map do |line|
        @name = line[:location].upcase
        @year = []
        @data_type = line[:dataformat].upcase
        economic_data_cleaner(line[:data], file)
        economic_year_cleaner(line[:timeframe])
        choose_economic_destiny(file)
      end
    end
  end

  def economic_data_cleaner(line_data, file)
    if line_data.to_f > 1
      @data = line_data.to_i
    elsif line_data.nil?
      @data = "N/A"
    else
      @data = line_data[0..4].to_f
    end
  end

  def economic_year_cleaner(line_timeframe)
    if line_timeframe.length > 4
      line_timeframe.sub(/[-]/, ' ' ).split.map {|year| @year << year.to_i}
    else
      @year = line_timeframe.to_i
    end
  end

  def choose_economic_destiny(file)
    populate_median_household_income(file) if file.include?("Median")
    populate_children_in_poverty(file) if file.include?("School")
    populate_free_or_reduced_price_lunch(file) if file.include?("free")
    populate_title_i(file) if file.include?("Title")
  end
end
