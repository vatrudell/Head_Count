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
    d = District.new({:name => "ACADEMY 20"})
    e = District.new({:name => "ADAMS COUNTY 14"})
    r = District.new({:name => "AGATE 300"})
    pp = District.new({:name => "AGUILAR REORGANIZED 6"})

    district = boop.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20" , district 
  end
end
