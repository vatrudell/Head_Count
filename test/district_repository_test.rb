require './test/test_helper'
require_relative '../lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  attr_reader :dr,
              :district
  def setup
      @dr = DistrictRepository.new
      dr.load_data({
       :enrollment => {
         :kindergarten => "./data/Kindergartners in full-day program.csv",
         :high_school_graduation => "./data/High school graduation rates.csv"}})
      @district = dr.find_by_name("ACADEMY 20")
  end

  def test_data_is_loaded_by_find_by_name
    assert_equal "ACADEMY 20", district.name
  end

  def test_find_by_name_doesnt_break
    district = dr.find_by_name("Another name that is wrong")
    assert_equal "You entered a district name that doens't exists!", district
  end

  def test_find_all_matching
    assert_equal 7, dr.find_all_matching("WE").count
  end

  def test_full_path_of_enrollment
    data = district.enrollment.kindergarten_participation_in_year(2005)
    assert_equal 0.2670, data
  end

  def test_kindergarten_participation_by_year
    data = district.enrollment.kindergarten_participation_by_year
    enrollment = {2007=>0.391,
                  2006=>0.353,
                  2005=>0.267,
                  2004=>0.302,
                  2008=>0.384,
                  2009=>0.39,
                  2010=>0.895,
                  2011=>0.895,
                  2012=>0.889,
                  2013=>0.913,
                  2014=>0.898}
    assert_equal enrollment, data
  end

  def test_participation_in_year
    actual = district.enrollment.kindergarten_participation_in_year(2008)
    expected = 0.384
    assert_equal expected, actual
  end

  def test_graduation_by_year
    actual = district.enrollment.graduation_rate_by_year
    expected = {2007=>0.391,
                2006=>0.353,
                2005=>0.267,
                2004=>0.302,
                2008=>0.384,
                2009=>0.39,
                2010=>0.895,
                2011=>0.895,
                2012=>0.889,
                2013=>0.913,
                2014=>0.898}
    assert_equal expected, actual
  end

  def test_participation_in_year
    actual = district.enrollment.graduation_rate_in_year(2010)
    expected = 0.895
    assert_equal expected, actual
  end
end
