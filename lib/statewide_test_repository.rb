require_relative '../lib/statewide_test'
require_relative '../lib/sanitation'
require 'pry'

class StatewideTestRepository
  include Sanitation
  attr_accessor :statewide_information

  def initialize
    @statewide_information = Hash.new(0)
  end

  def load_data(input)
    clean_up_statewide_test_data(input)
  end

  def populate_third_grade
    if statewide_information.keys.include? name
      if statewide_information[name].grade_three_proficient.has_key? year
        year_and_data = {}   #make instance variable
        year_and_data[concentration] = data
        statewide_information[name].grade_three_proficient[year].merge!(year_and_data)
      else
        statewide_information[name].grade_three_proficient.store(year, {concentration => data})
      end
    else
      statewide_information[name] =  StateWideTest.new({
        :name => name,
        :grade_three_proficient => {year => {concentration => data}}})
    end
  end

  def populate_eighth_grade
    if statewide_information.keys.include? name
      if statewide_information[name].grade_eight_proficient.has_key? year
        year_and_data = {}
        year_and_data[concentration] = data
        statewide_information[name].grade_eight_proficient[year].merge!(year_and_data)
      else
        statewide_information[name].grade_eight_proficient.store(year, {concentration => data})
      end
    else
      statewide_information[name].grade_eight_proficient.store(race, {year => {name => data}})
    end
  end

  def populate_average_proficiency
    if statewide_information[name].average_proficiency.has_key? race
      if statewide_information[name].average_proficiency[race].has_key? year
        year_and_data = {}
        year_and_data[name] = data
        statewide_information[name].average_proficiency[race].merge!(year_and_data)
      else
        race_hash = {}
        race_hash[year] = {name => data}
        statewide_information[name].average_proficiency[race].merge!(race_hash)
      end
    else
      statewide_information[name].average_proficiency.store(race, {year => {name => data}})
    end
  end

  def test_shit
    binding.pry
  end
end

    #sanitation  ---->
    #==================================
      #input[:statewide_testing].each do |name, value|
        #file = input[:statewide_testing][name]
        #@data = CSV.open(file, headers: true, header_converters: :symbol)
        #===============================

        # @data.each do |line|
        #   #can get rid of after sanitation
        #   @district_name = line[:location]    #@name in sanitation
        #   @year = line[:timeframe]      #.to_i      #@year in sanitation
        #     if line[:score] == "Math"
        #       @concentration = :math
        #     elsif line[:score] == "Writing"
        #       @concentration = :writing
        #     elsif line[:score] == "Reading"
        #       @concentration = :reading
        #     end
        #
        #     #essential keep
        #     #=======================
        #     # if data.nil?
        #       #data == 0
        #     #end
        #     #=====================
        #
        #     if line[:data].nil?
        #       @district_data =  "N/A"
        #     else
        #       @district_data =  (line[:data][0..4].to_f)
        #     end
        #
        #
        #     #can get rid of after sanitation
        #
        #     if line[:race_ethnicity] == "All Students"
        #       @race = :all_students
        #     elsif line[:race_ethnicity] == "Asian"
        #       @race = :asian
        #     elsif line[:race_ethnicity] == "Black"
        #       @race = :black
        #     elsif line[:race_ethnicity] == "Hawaiian/Pacific Islander"
        #       @race = :pacific_islander
        #     elsif line[:race_ethnicity] == "Hispanic"
        #       @race = :hispanic
        #     elsif line[:race_ethnicity] == "Native American"
        #       @race = :native_american
        #     elsif line[:race_ethnicity] == "Two or more"
        #       @race = :two_or_more
        #     elsif line[:race_ethnicity] == "White"
        #       @race = :white
        #     end





#
#               #populate reading
#               #============================================
#           #  elsif name == :reading
#               # if @statewide_information[@district_name].average_proficiency.has_key? @race
#               #   if @statewide_information[@district_name].average_proficiency[@race].has_key? @year
#               #     new_statewide = {}
#               #     new_statewide[name] = @district_data
#               #     @statewide_information[@district_name].average_proficiency[@race][@year].merge!(new_statewide)
#               #   else
#               #     new_statewide = {}
#               #     new_statewide[@year] = {name => @district_data}
#               #     @statewide_information[@district_name].average_proficiency[@race].merge!(new_statewide)
#               #   end
#               # else
#               #   @statewide_information[@district_name].average_proficiency.store(@race, {@year => {name => @district_data}})
#               #     new_statewide = {}
#               #     new_statewide[name] = @district_data
#               #     @statewide_information[@district_name].average_proficiency[@race].merge!(new_statewide)
#               # end
#
#               #populate writng
#               #============================================
#             #elsif name == :writing
#             #   if @statewide_information[@district_name].average_proficiency.has_key? @race
#             #     if @statewide_information[@district_name].average_proficiency[@race].has_key? @year
#             #       new_statewide = {}
#             #       new_statewide[name] = @district_data
#             #       @statewide_information[@district_name].average_proficiency[@race][@year].merge!(new_statewide)
#             #     else
#             #       new_statewide = {}
#             #       new_statewide[@year] = {name => @district_data}
#             #       @statewide_information[@district_name].average_proficiency[@race].merge!(new_statewide)
#             #     end
#             #   else
#             #     @statewide_information[@district_name].average_proficiency.store(@race, {@year => {name => @district_data}})
#             #       new_statewide = {}
#             #       new_statewide[name] = @district_data
#             #       @statewide_information[@district_name].average_proficiency[@race].merge!(new_statewide)
#             #   end
#             # end








#             #need this or version of it
#           #elsif name == :third_grade
#             #repeat each new populate
#             @statewide_information[@district_name] =  StateWideTest.new({:name => @district_name, :grade_three_proficient => {@year => {@concentration => @district_data}}})
#           #end
#         #end
#       #end
#     #end
#
#     #keep below we need this method
# #=========================
#     def find_by_name(district)
#       @statewide_information[district]
#     end
#   end
