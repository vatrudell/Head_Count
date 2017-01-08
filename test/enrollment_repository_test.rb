require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'



class EnrollmentRepositoryTest < Minitest::Test
  attr_reader :boop
  def setup
      @er = EnrollmentRepository.new
      @er.load_data({
               :enrollment => {
                 :kindergarten => "./data/Kindergartners in full-day program.csv"
               }
             })
     @enrollment = @er.find_by_name("ACADEMY 20")
  end

  def test_enrollment_is_created_through_enrollment_repo
   assert_equal "ACADEMY 20", @enrollment.name
  end

  
end
