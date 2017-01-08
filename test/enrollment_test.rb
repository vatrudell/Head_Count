require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnrollmentTest < Minitest::Test
  attr_reader :boop
  def setup
      @er = Enrollment.new({:name => "ACADEMY 20",
                            :kindergarten_participation =>
                              {2010 => 0.3915,
                               2011 => 0.35356,
                               2012 => 0.2677}})
  end


  def test_enrollment_has_a_class
    assert_equal Enrollment, @er.class
  end

  def test_it_has_a_name
    assert_equal "ACADEMY 20", @er.name
  end

  def test_kindergarten_participation_by_year
    by_year = {2010 => 0.391,
     2011 => 0.353,
     2012 => 0.267}
    assert_equal by_year, @er.kindergarten_participation_by_year
  end

  def test_kindergarden_partipation_in_year
    assert_equal 0.353, @er.kindergarten_participation_in_year(2011)
  end
end


# e.kindergarten_participation_in_year(2010)
# e.kindergarten_participation_by_year
