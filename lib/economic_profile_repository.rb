require_relative '../lib/economic_profile'
require_relative '../lib/sanitation'
require 'pry'
require'csv'

class EconomicProfileRepository
  include Sanitation
  attr_reader :economic_profiles

  def initialize
    @economic_profiles = Hash.new(0)
  end

  def load_data(input)
    clean_up_economic_data(input)
  end

  def populate_median_household_income(opened_file)
    if economic_profiles.keys.include?(@name)
      median_household_addition = {}
      median_household_addition[@year] = @data
      economic_profiles[@name].median_household_income.merge!(median_household_addition)
    else
      @economic_profiles[@name] = EconomicProfile.new({name: @name, median_household_income: {@year => @data}})
    end
  end

  def populate_children_in_poverty(opened_file)
    if @data_type == "PERCENT"
      poverty_data_addition = {}
      poverty_data_addition[@year] = @data
      economic_profiles[@name].children_in_poverty.merge!(poverty_data_addition)
    end
  end

  def populate_free_or_reduced_price_lunch(opened_file)
    if @data_type == "PERCENT"
      if economic_profiles[@name].free_or_reduced_price_lunch.include?(@year)
        lunch_data_addition = {}
        lunch_data_addition[:percent] = @data
        economic_profiles[@name].free_or_reduced_price_lunch[@year].merge!(lunch_data_addition)
      else
        economic_profiles[@name].free_or_reduced_price_lunch[@year] = {:percent=> @data}
      end
    end
    populate_free_or_reduced_price_lunch_total(opened_file)
  end

  def populate_free_or_reduced_price_lunch_total(opened_file)
    if @data_type == "NUMBER"
      if economic_profiles[@name].free_or_reduced_price_lunch.include?(@year)
        lunch_data_addition = {}
        lunch_data_addition[:total] = @data
        economic_profiles[@name].free_or_reduced_price_lunch[@year].merge!(lunch_data_addition)
      else
        economic_profiles[@name].free_or_reduced_price_lunch[@year] = {:total => @data}
      end
    end
  end

  def populate_title_i(opened_file)
    title_i_addition = {}
    title_i_addition[@year] = @data
    economic_profiles[@name].title_i.merge!(title_i_addition)
  end

  def find_by_name(name)
    @economic_profiles[name]
  end

  def test_shit
    binding.pry
  end
end


epr = EconomicProfileRepository.new
    epr.load_data({
                    :economic_profile => {
                      :median_household_income => "./data/Median household income.csv",
                      :children_in_poverty => "./data/School-aged children in poverty.csv",
                      :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                      :title_i => "./data/Title I students.csv"
                    }
                  })

    epr.test_shit