require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class EnrollmentTest < Minitest::Test
  attr_reader :boop
  # def setup
  #     @er = Enrollment.new({:name => "ACADEMY 20",
  #                           :kindergarten_participation =>
  #                             {2010 => 0.3915,
  #                              2011 => 0.35356,
  #                              2012 => 0.2677}})
  # end


  # def test_enrollment_has_a_class
  #   assert_equal Enrollment, @er.class
  # end

  # def test_it_has_a_name
  #   assert_equal "ACADEMY 20", @er.name
  # end

  # def test_kindergarten_participation_by_year
  #   by_year = {2010 => 0.391,
  #    2011 => 0.353,
  #    2012 => 0.267}
  #   assert_equal by_year, @er.kindergarten_participation_by_year
  # end

  # def test_kindergarden_partipation_in_year
  #   assert_equal 0.353, @er.kindergarten_participation_in_year(2011)
  # end

  def test_enrollment_repository_with_high_school_data
    er = EnrollmentRepository.new
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    e = er.find_by_name("MONTROSE COUNTY RE-1J")


    expected = {2010=>0.738, 2011=>0.751, 2012=>0.777, 2013=>0.713, 2014=>0.757}
    expected.each do |k,v|
      assert_in_delta v, e.graduation_rate_by_year[k], 0.005
    end
    assert_in_delta 0.738, e.graduation_rate_in_year(2010), 0.005
  end
end


# e.kindergarten_participation_in_year(2010)
# e.kindergarten_participation_by_year
