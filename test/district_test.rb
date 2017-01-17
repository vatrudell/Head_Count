require './test/test_helper'
require_relative '../lib/district'
require_relative '../lib/district_repository'
require_relative '../lib/economic_profile_repository'


class DistrictTest < Minitest::Test
  attr_accessor :district,
                :district_repository,
                :name_of_district
  def setup
    @district  = District.new({:name => "ACADEMY 20"})
    @district_repository = DistrictRepository.new
    @econ = EconomicProfileRepository.new
    district_repository.load_data({:enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv",
      :high_school_graduation => "./data/High school graduation rates.csv"},
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
  "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
  }})
    @name_of_district = district_repository.find_by_name("ACADEMY 20")
  end

  def test_district_is_created
    actual = {:name=>"ACADEMY 20"}
    assert_equal actual, district.name
  end
end
