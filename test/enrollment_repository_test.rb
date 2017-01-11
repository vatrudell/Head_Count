require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnrollmentRepositoryTest < Minitest::Test
  attr_reader :er,
              :enrollment_in_district
  def setup
      @er = EnrollmentRepository.new
      er.load_data({ :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"}})
      @enrollment_in_district = er.find_by_name("ACADEMY 20")
  end

  def test_load_data_makes_high_school_graduation_rates
    expected = {2010=>0.895,
                2011=>0.895,
                2012=>0.889,
                2013=>0.913,
                2014=>0.898}
    assert_equal expected, enrollment_in_district.high_school_graduation
  end

  def test_load_data_makes_kinderguarden_participation_rates
    expected = {2007=>0.391,
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
    assert_equal expected, enrollment_in_district.kindergarten_participation
  end

  def test_enrollment_is_created_through_enrollment_repo
    assert_equal "ACADEMY 20", enrollment_in_district.name
  end

  def test_find_by_name
    assert_equal Enrollment, enrollment_in_district.class
  end
end
