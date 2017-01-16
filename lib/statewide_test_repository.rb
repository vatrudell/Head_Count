require_relative '../lib/statewide_test'
require_relative '../lib/sanitation'
require 'pry'

class StatewideTestRepository
  include Sanitation
  attr_accessor :statewide_information,
                :derp_information

  def initialize
    @statewide_information = Hash.new(0)
    @derp_information = Hash.new(0)
  end

  def load_data(input)
    clean_up_statewide_data(input)
  end

  def populate_third_grade
    if statewide_information.keys.include? name
      if statewide_information[name].grade_three_proficient.has_key?(year)
        year_and_data = {}   #make instance variable
        year_and_data[concentration] = data
        statewide_information[name].grade_three_proficient[year].
          merge!(year_and_data)
      else
        statewide_information[name].grade_three_proficient.
          store(year, {concentration => data})
      end
    else
      statewide_information[name] = StateWideTest.new({
        :name => name,
        :grade_three_proficient => {year => {concentration => data}}})
    end
  end

  def populate_eighth_grade
    if statewide_information.keys.include? name
      if statewide_information[name].grade_eight_proficient.has_key?(year)
        year_and_data = {}
        year_and_data[concentration] = data
        statewide_information[name].grade_eight_proficient[year].
          merge!(year_and_data)
      else
        statewide_information[name].grade_eight_proficient.
          store(year, {concentration => data}
      end
    else
      statewide_information[name] =  StateWideTest.new({
        :name => name,
        :grade_eight_proficient => {year => {concentration => data}}})
    end
  end

  def populate_average_proficiency
    binding.pry
    if derp_information.keys.include?(name)
      if derp_information[name].average_proficiency.has_key?(race)
        if derp_information[name].average_proficiency[race].has_key?(year)
          add_existing_year = {year => {concentration => data}}
          derp_information[name].average_proficiency[race][year].
          merge!(add_existing_year)
        else
          add_existing_year = {year => {concentration => data}}
          derp_information[name].average_proficiency[race].
          merge!(add_existing_year)
        end
      else
        new_derp = derp_information[name].average_proficiency.
        store(race, {year => {concentration => data}})
        derp_information[name].average_proficiency[race].
          merge!(new_derp)
      end
    else
      derp_information[name] = StateWideTest.new({
        :name => name,
        :average_proficiency => {race => {year => {concentration => data}}}})
    end
  end

  def test_shit
    binding.pry
  end
end

#     #keep below we need this method
# #=========================
#     def find_by_name(district)
#       @statewide_information[district]
#     end
#   end
