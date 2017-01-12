require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class StateWideTestTest < Minitest::Test
  attr_reader :statewide,
              :str,
              :str,
              :district
  def setup
    @statewide = StateWideTest.new
    @str = StateWideTestRepository.new
    @str.load_data({:statewide_testing => {
      :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
      :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
      :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})
    @district = str.find_by_name("ACADEMY 20")
  end

  def test_statewide_name
    assert_equal "ACADEMY 20", district.name
  end

  # def test_statewide_grade_three_proficient
  #
  # end
  #
  # def test_statewide_grade_eith_proficient
  #
  # end
  #
  # def test_average_proficiency
  #
  # end
  #
  # def test_proficient_by_grade
  #
  # end
  #
  # def test_proficient_by_race_or_ethnicity
  #
  # end
  #
  # def test_proficient_for_subject_by_grade_in_year
  #
  # end
  #
  # def proficient_for_subject_by_race_in_year
  #
  # end
end



#str.find_by_name("ACADEMY 20")
#     abalone = str.find_by_name("ACADEMY 20")
#     abalone.proficient_by_grade(3)
#     abalone.proficient_by_race_or_ethnicity(:white)
#     abalone.proficient_for_subject_by_grade_in_year(:math, 8, 2010)
#     abalone.proficient_for_subject_by_race_in_year(:math, :asian, 2011)
