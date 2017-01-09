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
    #binding.pry
    assert_equal 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
    assert_in_delta 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1'), 0.005
  end

  def test_enrollment_analysis_rate_variation_trend
    #puts out corrent input, but since number is .001 off it doens't pass
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    ha = HeadcountAnalyst.new(dr)


    compare = ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
    output =  {2007=>0.391,
                 2006=>0.353,
                 2005=>0.267,
                 2004=>"N/A",
                 2008=>0.384,
                 2009=>0.39,
                 2010=>0.436,
                 2011=>0.489,
                 2012=>0.478,
                 2013=>0.487,
                 2014=>0.49}

    colorado_output= {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
    assert_equal colorado_output, compare
  end
end
