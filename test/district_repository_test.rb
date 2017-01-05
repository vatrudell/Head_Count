require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/district_repository'



class DistrictRepositoryTest < Minitest::Test
  attr_reader :dr
  def setup
      @dr = DistrictRepository.new
  end

  def test_that_repository_holds_district_instances
    dr.load_data({
                  :enrollment => {
                  :kindergarten =>
                  "./data/Kindergartners in full-day program.csv"}})

    all_of_district = ["ACADEMY 20,2007,Percent,0.39159",
    "ACADEMY 20,2006,Percent,0.35364",
    "ACADEMY 20,2005,Percent,0.26709",
    "ACADEMY 20,2004,Percent,0.30201",
    "ACADEMY 20,2008,Percent,0.38456",
    "ACADEMY 20,2009,Percent,0.39",
    "ACADEMY 20,2010,Percent,0.43628",
    "ACADEMY 20,2011,Percent,0.489",
    "ACADEMY 20,2012,Percent,0.47883",
    "ACADEMY 20,2013,Percent,0.48774",
    "ACADEMY 20,2014,Percent,0.49022"]
    assert_equal all_of_district , dr.find_by_name("ACADEMY 20")
  end
end
