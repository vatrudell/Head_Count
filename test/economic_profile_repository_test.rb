require './test/test_helper'
require_relative '../lib/economic_profile_repository'

class EconomicProfileRepositoryTest < Minitest::Test
  def test_economic_profiles_are_loaded
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income =>
        "./data/Median household income.csv",
        :children_in_poverty =>
        "./data/School-aged children in poverty.csv",
        :free_or_reduced_price_lunch =>
        "./data/Students qualifying for free or reduced price lunch.csv",
        :title_i =>
        "./data/Title I students.csv"}})

    assert_equal EconomicProfile, epr.find_by_name("ACADEMY 20").class
  end
end
