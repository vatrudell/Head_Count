
require './test/test_helper'
require_relative '../lib/statewide_test_repository'


class StateWideTestRepositoryTest < Minitest::Test
  def test_new_repository
    stwr = StatewideTestRepository.new
    stwr.load_data({:statewide_testing => {
      :third_grade =>
  "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
      :eighth_grade =>
  "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
      :math =>
  "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
      :reading =>
  "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
      :writing =>
  "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }})
    stwr.test_shit
    #str = str.find_by_name("ACADEMY 20")
    assert_equal "derp", "derp"
  end
end
