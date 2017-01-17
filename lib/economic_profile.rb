require 'pry'
require_relative "../lib/unknown_data_error"

class EconomicProfile
  # include Alert
  attr_reader :median_household_income,
              :children_in_poverty,
              :free_or_reduced_price_lunch,
              :title_i,
              :name

  def initialize(data)
    @median_household_income = data[:median_household_income]
    @children_in_poverty = data[:children_in_poverty] || Hash.new
    @free_or_reduced_price_lunch =data[
      :free_or_reduced_price_lunch] || Hash.new
    @title_i = data[:title_i] || Hash.new
    @name = data[:name] || Hash.new
  end

  def median_household_income_in_year(year)
    median_income = 0
      median_household_income.keys.each do |years|
      if years.include?(year)
        median_income = median_household_income[years]
      end
    end
    median_income
  end

  def median_household_income_average
    (median_household_income.values.
    reduce(:+))/median_household_income.values.count
  end

  def children_in_poverty_in_year(year)
    if year_included(children_in_poverty, year)
      children_in_poverty[year]
    end
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    if year_included(free_or_reduced_price_lunch, year)
      free_or_reduced_price_lunch[year][:percent]
    end
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    if year_included(free_or_reduced_price_lunch, year)
      free_or_reduced_price_lunch[year][:total]
    end
  end

  def title_i_in_year(year)
    if year_included(title_i, year)
      title_i[year]
    end
  end

  def year_included(data, year)
    true if data.keys.include?(year)

    # else
    #   raise UnknownDataError
    # end
  end
end
