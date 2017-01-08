require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'



class DistrictTest < Minitest::Test
  attr_reader :boop,
              :d_repo
  def setup
      @boop = District.new({:name => "ACADEMY 20"})
      @d_repo = DistrictRepository.new
      @d_repo.load_data({
                     :enrollment => {
                       :kindergarten => "./data/Kindergartners in full-day program.csv"}})

      @district = @d_repo.find_by_name("ACADEMY 20")
  end

  def test_district_is_created
    #passes
    assert_equal "ACADEMY 20", boop.name
  end

  def test_ditrict_is_created_through_repository
    #passes
    assert_equal "ACADEMY 20", @district.name
  end

  def find_enrollment
    #passes
    enrollment =  {"2007"=>"0.39159",
   "2006"=>"0.35364",
   "2005"=>"0.26709",
   "2004"=>"0.30201",
   "2008"=>"0.38456",
   "2009"=>"0.39",
   "2010"=>"0.43628",
   "2011"=>"0.489",
   "2012"=>"0.47883",
   "2013"=>"0.48774",
   "2014"=>"0.49022"}
    assert_equal  enrollment, @district.enrollment

  end

  def test_find_enrollment_in_kindergarden_year
    #passes
    data_1 = @district.enrollment.kindergarten_participation_in_year(2004)
    data_2 = @district.enrollment.kindergarten_participation_in_year(2005)
    data_3 = @district.enrollment.kindergarten_participation_in_year(2008)
    data_4 = @district.enrollment.kindergarten_participation_in_year(2010)
    data_5 = @district.enrollment.kindergarten_participation_in_year(2012)

    assert_equal 0.3020, data_1
    assert_equal 0.2670, data_2
    assert_equal 0.3845, data_3
    assert_equal 0.4362, data_4
    assert_equal 0.4788, data_5
  end
end
