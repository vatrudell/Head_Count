require './test/test_helper'
require_relative '../lib/enrollment'
require_relative '../lib/enrollment_repository'

class EnrollmentTest < Minitest::Test
  attr_reader :er,
              :enrollment_in_district
  def setup
    @er = EnrollmentRepository.new
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    @enrollment_in_district = er.find_by_name("MONTROSE COUNTY RE-1J")
  end

  def test_it_has_a_name
    assert_equal  "MONTROSE COUNTY RE-1J", enrollment_in_district.name
  end

  def test_kindergarten_participation_by_year
    by_year = {2007=>0.057,
              2006=>0.0,
              2005=>0.0,
              2004=>0.0,
              2008=>0.182,
              2009=>0.27,
              2010=>0.317,
              2011=>0.461,
              2012=>0.525,
              2013=>0.592,
              2014=>0.775}
    by_year.each do |year, data|
      assert_in_delta data, enrollment_in_district.kindergarten_participation_by_year[year], 0.005
    end
  end

  def test_kindergarden_partipation_in_year
    assert_in_delta 0.461, enrollment_in_district.kindergarten_participation_in_year(2011), 0.005
  end

  def test_enrollment_repository_high_school_graduation_in_year
    assert_in_delta 0.738, enrollment_in_district.graduation_rate_in_year(2010), 0.005
  end

  def test_enrollment_repository_with_high_graduation_by_year
    expected = {2010=>0.738,
                2011=>0.751,
                2012=>0.777,
                2013=>0.713,
                2014=>0.757}
    expected.each do |year, data|
      assert_in_delta data, enrollment_in_district.graduation_rate_by_year[year], 0.005
    end
  end

end
