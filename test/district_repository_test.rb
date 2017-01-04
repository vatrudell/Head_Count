require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'



class DistrictRepositoryTest < Minitest::Test
  attr_reader :boop
  def setup
      @boop = DistrictRepository.new
  end

  def test_that_repository_holds_district_instances
    boop.load_data({
                  :enrollment => {
                  :kindergarten =>
                  "./data/Kindergartners in full-day program.csv"}})

    district_name = boop.find_by_name("ACADEMY 20")
    all_of_district = "ACADEMY 20,2007,Percent,0.39159
    ACADEMY 20,2006,Percent,0.35364
    ACADEMY 20,2005,Percent,0.26709
    ACADEMY 20,2004,Percent,0.30201
    ACADEMY 20,2008,Percent,0.38456
    ACADEMY 20,2009,Percent,0.39
    ACADEMY 20,2010,Percent,0.43628
    ACADEMY 20,2011,Percent,0.489
    ACADEMY 20,2012,Percent,0.47883
    ACADEMY 20,2013,Percent,0.48774
    ACADEMY 20,2014,Percent,0.49022"
    assert_equal all_of_district , district_name
  end
end
