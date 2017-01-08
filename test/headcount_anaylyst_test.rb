require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
#require './lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  def test_enrollment_analysis_rate_variation
  dr = DistrictRepository.new
  dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
  ha = HeadcountAnalyst.new(dr)
  assert_in_delta 1.126, ha.kindergarten_participation_rate_variation("GUNNISON WATERSHED RE1J", :against => "TELLURIDE R-1"), 0.005
  assert_in_delta 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1'), 0.005
  end

  def test_enrollment_analysis_rate_variation_trend

  end
end
