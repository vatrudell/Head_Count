require './test/test_helper'
require_relative '../lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  attr_reader   :dr
  def setup
    @dr = DistrictRepository.new
    dr.load_data({:enrollment => {
      :kindergarten =>
      "./data/Kindergartners in full-day program.csv",
      :high_school_graduation =>
      "./data/High school graduation rates.csv"},
                 :statewide_testing => {
      :third_grade =>
      "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
      :eighth_grade =>
      "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
      :math =>
      "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
      :reading =>
      "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
      :writing =>
      "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})
  end

  def test_find_by_name
    assert_equal District, dr.find_by_name("ACADEMY 20").class
  end

  def test_find_all_matching
    assert_equal 1, dr.find_all_matching("ACADEMY 20").count
  end

  def test_find_enrollment
    assert_equal Enrollment, dr.find_enrollment("ACADEMY 20").class
  end

  def test_find_statewide_test
    assert_equal StateWideTest, dr.find_statewide_test("ACADEMY 20").class
  end
end
