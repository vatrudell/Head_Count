require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'



class DistrictTest < Minitest::Test
  # attr_reader :boop
  # def setup
  #     @boop = District.new
  # end

  def test_district_is_created
    d = District.new({:name => "ACADEMY 20"})

    assert_equal "ACADEMY 20", d.name
  end
end
