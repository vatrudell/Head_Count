require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnrollmentTest < Minitest::Test
  attr_reader :boop
  def setup
      @boop = Enrollment.new
  end

  def test_that_test_helper_requires_district
    assert_equal "derp derp derp", boop.derp
  end
end
