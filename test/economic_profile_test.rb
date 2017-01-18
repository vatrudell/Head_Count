require './test/test_helper'
require_relative '../lib/economic_profile_repository'

class EconomicProfileRepositoryTest < Minitest::Test
  attr_reader   :epr,
                :district
  def setup
    @epr = EconomicProfileRepository.new
        epr.load_data({
          :economic_profile => {
            :median_household_income =>
            "./data/Median household income.csv",
            :children_in_poverty =>
            "./data/School-aged children in poverty.csv",
            :free_or_reduced_price_lunch =>
            "./data/Students qualifying for free or reduced price lunch.csv",
            :title_i =>
            "./data/Title I students.csv"}})
    @district = epr.find_by_name("ACADEMY 20")
  end

  def test_median_household_income
    actual = district.median_household_income
    expected = {[2005, 2009]=>85060,
                [2006, 2010]=>85450,
                [2008, 2012]=>89615,
                [2007, 2011]=>88099,
                [2009, 2013]=>89953}
    assert_equal expected, actual
  end

  def test_children_in_poverty
    actual = district.children_in_poverty
    expected = {1995=>0.032,
                1997=>0.035,
                1999=>0.032,
                2000=>0.031,
                2001=>0.029,
                2002=>0.033,
                2003=>0.037,
                2004=>0.034,
                2005=>0.042,
                2006=>0.036,
                2007=>0.039,
                2008=>0.044,
                2009=>0.047,
                2010=>0.057,
                2011=>0.059,
                2012=>0.064,
                2013=>0.048}
    assert_equal expected, actual
  end

  def test_free_or_reduced_price_luch
    actual = district.free_or_reduced_price_lunch
    expected = {2014=>{:total=>976, :percent=>0.087},
                2012=>{:percent=>0.125, :total=>3006},
                2011=>{:total=>2834, :percent=>0.084},
                2010=>{:percent=>0.079, :total=>774},
                2009=>{:total=>739, :percent=>0.07},
                2013=>{:percent=>0.091, :total=>977},
                2008=>{:total=>1343, :percent=>0.061},
                2007=>{:percent=>0.05, :total=>1071},
                2006=>{:total=>653, :percent=>0.041},
                2005=>{:percent=>0.058, :total=>1204},
                2004=>{:total=>681, :percent=>0.034},
                2003=>{:percent=>0.03, :total=>435},
                2002=>{:total=>396, :percent=>0.027},
                2001=>{:percent=>0.024, :total=>407},
                2000=>{:total=>332, :percent=>0.02}}
    assert_equal expected, actual
  end

  def test_title_i
    actual = district.title_i
    expected = {2009=>0.014,
                2011=>0.011,
                2012=>0.01,
                2013=>0.012,
                2014=>0.027}
    assert_equal expected, actual
  end

  def test_name
    actual =  district.name
    expected = "ACADEMY 20"
    assert_equal expected, actual
  end

  def test_median_household_income_in_year
    actual = district.median_household_income_in_year(2011)
    expected = 88099
    assert_equal expected, actual
  end
  #bad med houshold year
  #data is bad for year

  def test_median_household_income_average
    actual = district.median_household_income_average
    expected = 87635
    assert_equal expected, actual
  end

  def test_children_in_poverty_in_year
    actual = district.children_in_poverty_in_year(2012)
    expected =  0.064
    assert_equal expected, actual
  end
  # bad children_in_poverty for year
  # data is bad for year

  def test_free_or_reduced_price_lunch_percentage_in_year
    #skip # values returns nil
    actual = district.free_or_reduced_price_lunch_percentage_in_year(2012)
    expected =  0.125
    assert_equal expected, actual
  end
  #bad free or reduced year
  #data is bad for year

  def test_free_or_reduced_price_lunch_number_in_year
    actual = district.free_or_reduced_price_lunch_number_in_year(2014)
    expected = 976
    assert_equal expected, actual
  end
  #bad free or reduced year
  #data is bad for year

  def test_title_i_in_year
    actual = district.title_i_in_year(2014)
    expected = 0.027
    assert_equal expected, actual
  end
  #bad title_i year
  #data is bad for year
end
