require './test/test_helper'
require_relative '../lib/enrollment'
require_relative '../lib/enrollment_repository'

class EnrollmentTest < Minitest::Test
  def test_find_by_name
    er = EnrollmentRepository.new
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    enrollment_in_district = er.find_by_name("MONTROSE COUNTY RE-1J")
  end
end 
