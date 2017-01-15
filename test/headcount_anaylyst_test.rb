require './test/test_helper'
require_relative '../lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  attr_reader :dr,
              :ha,
              :enrollment_in_district
  def setup
    @dr = DistrictRepository.new
    dr.load_data({ :enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv",
      :high_school_graduation => "./data/High school graduation rates.csv"}})
    @ha = HeadcountAnalyst.new(dr)
    #@enrollment_in_district = er.find_by_name("COLORADO")
  end

  def test_enrollment_analysis_basics
    actual_1 = ha.kindergarten_participation_rate_variation(
    "GUNNISON WATERSHED RE1J", :against => "TELLURIDE R-1")
    assert_in_delta 1.126, actual_1, 0.005
    actual_2 = ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
    assert_in_delta 0.447, actual_2, 0.005
  end


  def test_enrollment_analysis_rate_variation_trend
    #passes
    compare = ha.kindergarten_participation_rate_variation_trend(
          'ACADEMY 20',
          :against => 'COLORADO')
    colorado_output= {2004=>1.258,
                      2005=>0.96,
                      2006=>1.051,
                      2007=>0.992,
                      2008=>0.718,
                      2009=>0.652,
                      2010=>0.681,
                      2011=>0.728,
                      2012=>0.688,
                      2013=>0.694,
                      2014=>0.661}
    assert_equal colorado_output, compare
  end

  def test_highschool_participation_against_graduation
    expected = ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20")
    actual =  0.452
    assert_equal actual, expected
  end

#   def test_participation_and_graduation_coorelate
#     #passes
#     expected = ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
#     actual = false
#     assert_equal actual, expected
#   end
#
#   def test_kindergarden_agianst_highschool_for_statewide
#     #passes
#     expected = ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'STATEWIDE')
#     actual = false
#     assert_equal actual, expected
#   end
# end
end
