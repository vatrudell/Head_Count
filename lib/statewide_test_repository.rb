require 'csv'
require_relative '../lib/statewide_test'
require 'pry'
require_relative '../lib/sanitation'

class StatewideTestRepository
  include Sanitation
  attr_accessor :statewide_information

  def initialize
    @statewide_information = Hash.new(0)
  end

  def load_data(input)
    clean_up_statewide_data(input)
  end

  def populate_third_grade(name)
    if @statewide_information.keys.include? @district_name.upcase
      populate_third_grade_with_existing_district(name)
    else
      populate_third_grade_creating_new_district(name)
    end
  end
  
  def populate_third_grade_with_existing_district(name)
    if @statewide_information[@district_name.upcase].grade_three_proficient.has_key? @year
      new_statewide = {}
      new_statewide[@concentration] = @district_data
      @statewide_information[@district_name.upcase].grade_three_proficient[@year].merge!(new_statewide)
    else
      @statewide_information[@district_name.upcase].grade_three_proficient.store(@year, {@concentration => @district_data})
    end
  end
    
  def populate_third_grade_creating_new_district(name)
      @statewide_information[@district_name.upcase] = StateWideTest.new({:name => @district_name, :grade_three_proficient => {@year => {@concentration => @district_data}}})
  end
 

  def populate_eighth_grade(name)
    if @statewide_information[@district_name.upcase].grade_eight_proficient.has_key? @year
      new_statewide = {}
      new_statewide[@concentration] = @district_data
      @statewide_information[@district_name.upcase].grade_eight_proficient[@year].merge!(new_statewide)
    else
      @statewide_information[@district_name.upcase].grade_eight_proficient.store(@year, {@concentration => @district_data})
    end
  end
            
  def populate_average_proficiency(name)
    if @statewide_information[@district_name.upcase].average_proficiency.has_key? @race
      populate_average_with_existing_year(name)
    else
      populate_average_with_new_year(name)
    end
  end

  def populate_average_with_existing_year(name)
    if @statewide_information[@district_name.upcase].average_proficiency[@race].has_key? @year
      new_statewide = {}
      new_statewide[name] = @district_data
      @statewide_information[@district_name.upcase].average_proficiency[@race][@year].merge!(new_statewide)
    else
      new_statewide = {}
      new_statewide[@year] = {name => @district_data}
      @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
    end
  end
  
  def populate_average_with_new_year(name)
    @statewide_information[@district_name.upcase].average_proficiency.store(@race, {@year => {name => @district_data}})
      unless name == :math
        new_statewide = {}
        new_statewide[name] = @district_data
        @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
      end
  end
         
  def find_by_name(district)
    @statewide_information[district]
  end

  def test_repo
    binding.pry
  end
end

#  str = StatewideTestRepository.new
#     str.load_data({
#                     :statewide_testing => {
#                       :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
#                       :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
#                       :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
#                       :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
#                       :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
#                     }
#                   })
#     str.find_by_name('ACADEMY 20')
#     str.test_repo