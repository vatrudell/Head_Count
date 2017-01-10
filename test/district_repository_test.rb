require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/district_repository'



class DistrictRepositoryTest < Minitest::Test
  attr_reader :dr
  def setup
      @dr = DistrictRepository.new
      @dr.load_data({
                     :enrollment => {
                       :kindergarten => "./data/Kindergartners in full-day program.csv"
                     }
                   })
      #@district = dr.find_by_name("ACADEMY 20")
  end

  def test_data_is_loaded_by_find_by_name
    #passes
    assert_equal "ACADEMY 20", @district.name
  end 

  def test_find_by_name 
    district = dr.find_by_name("ACADEMY 20")
    assert_equal District, district 
  end   

  def test_find_all_matching
    #passes
    assert_equal 7, @dr.find_all_matching("WE").count
  end

    # dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv",
    #                               :high_school_graduation => "./data/High school graduation rates.csv"}})

  # puts dr.find_by_name("ACADEMY 20")
 


  #
  # def test_find_enrollment
  #   #passes
  #   enrollment = {2007=>0.39465,
  #   2006=>0.33677,
  #   2005=>0.27807,
  #   2004=>0.24014,
  #   2008=>0.5357,
  #   2009=>0.598,
  #   2010=>0.64019,
  #   2011=>0.672,
  #   2012=>0.695,
  #   2013=>0.70263,
  #   2014=>0.74118}
  #
  #   colorado = @dr.find_enrollment("Colorado")
  #
  # assert_equal enrollment, colorado.kindergarten_participation
  # end
  #
  # def test_full_path_of_enrollment
  #   #passes
  #   data = @district.enrollment.kindergarten_participation_in_year(2005)
  #   assert_equal 0.2670, data
  # end
  #
  # def test_kindergarten_participation_by_year
  #   data = @district.enrollment.kindergarten_participation_by_year
  #   enrollment = {2007=>0.39465,
  #   2006=>0.33677,
  #   2005=>0.27807,
  #   2004=>0.24014,
  #   2008=>0.5357,
  #   2009=>0.598,
  #   2010=>0.64019,
  #   2011=>0.672,
  #   2012=>0.695,
  #   2013=>0.70263,
  #   2014=>0.74118}
  #   assert_equal enrollment, data
  # end


end
