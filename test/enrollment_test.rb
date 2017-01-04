require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnrollmentTest < Minitest::Test
  # attr_reader :boop
  # def setup
  #     @boop = Enrollment.new
  # end

  def test_that_
    e = Enrollment.new({:name => "ACADEMY 20",
                        :kindergarten_participation =>
                          {2010 => 0.3915,
                           2011 => 0.35356,
                           2012 => 0.2677}})
  end
end
