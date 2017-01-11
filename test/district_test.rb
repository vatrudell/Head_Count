require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'



class DistrictTest < Minitest::Test
  attr_reader :district,
              :district_repository,
              :name_of_district
  def setup
      @district  = District.new({:name => "ACADEMY 20"})
      @district_repository = DistrictRepository.new
      district_repository.load_data({
               :enrollment => {
                 :kindergarten => "./data/Kindergartners in full-day program.csv",
                 :high_school_graduation => "./data/High school graduation rates.csv"
               }
             })

      @name_of_district = district_repository.find_by_name("ACADEMY 20")
  end

  def test_district_is_created
    #passes
    assert_equal "ACADEMY 20", district.name
  end

  def test_enrollment_data
    #passes
    enrollment =  {2007=>0.391,
                 2006=>0.353,
                 2005=>0.267,
                 2004=>0.302,
                 2008=>0.384,
                 2009=>0.39,
                 2010=>0.436,
                 2011=>0.489,
                 2012=>0.478,
                 2013=>0.487,
                 2014=>0.49}
    assert_equal  enrollment, name_of_district.enrollment_data
  end

  def test_graduation_data
    graduation = {2010=>0.895,
                  2011=>0.895,
                  2012=>0.889,
                  2013=>0.913,
                  2014=>0.898}
    actual = @name_of_district.graduation_data
    assert_equal graduation, actual
  end

  def test_find_enrollment_in_kindergarden_year
    #passes
    data_1 = @name_of_district.enrollment.kindergarten_participation_in_year(2004)
    data_2 = @name_of_district.enrollment.kindergarten_participation_in_year(2005)
    data_3 = @name_of_district.enrollment.kindergarten_participation_in_year(2008)
    data_4 = @name_of_district.enrollment.kindergarten_participation_in_year(2010)
    data_5 = @name_of_district.enrollment.kindergarten_participation_in_year(2012)

    assert_equal 0.3020, data_1
    assert_equal 0.2670, data_2
    assert_equal 0.3845, data_3
    assert_equal 0.4362, data_4
    assert_equal 0.4788, data_5
  end
end
