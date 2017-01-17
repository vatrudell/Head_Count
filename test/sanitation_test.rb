require './test/test_helper'
require_relative '../lib/sanitation'
require_relative '../lib/district_repository'
require_relative '../lib/economic_profile_repository'
require_relative '../lib/statewide_test_repository'

 class SanitationTest < Minitest::Test
   include Sanitation
   attr_reader :file,
               :dr
              #:sanitize,
   def setup
    # @sanitize = Sanitation.new
    @dr = DistrictRepository.new
    @er = EnrollmentRepository.new
    @swt_repo = StatewideTestRepository.new
    @econ_repo = EconomicProfileRepository.new
    @file = {:enrollment => {
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
  "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
  }}
    dr.load_data(file)
   end

   def test_sanitation_cleans_district_data
     actual = dr.find_by_name("COLORADO").name
     expected = "COLORADO"
     assert_equal expected, actual
   end
 end
