#require 'csv'
require 'pry'
require_relative '../lib/district'
require_relative '../lib/enrollment_repository'
require_relative '../lib/statewide_test_repository'
require_relative '../lib/sanitation'

class DistrictRepository
  attr_accessor :districts,
  #will be replaced with :district_repository
                :enrollment_instance,
  #will be replaced with :enrollment_repository
                :statewide_instance,
#will be replaced with :statewide_test_repository
                :name,
                :concentration,
                :race,
                :year,
                :data,
                :cleaned_file


  def initialize
    @districts = {}
    @enrollment_instance = EnrollmentRepository.new  #enrollment_repository
    @statewide_instance = StatewideTestRepository.new #statewide_test_repository
  end

  def load_data(input)
    #enrollment_instance.load_data(input)
     input[:enrollment].values.each do |file|
      opened_file = CSV.open(file, headers: true, header_converters: :symbol)
      @cleaned_file = opened_file.map do |line|
        @name = line[:location].upcase
        @concentration = line[:score] unless :score == nil
        @race = line[:race_ethnicity] unless :race_ethnicity == nil
        @year = line[:timeframe].to_i
        @data = line[:data][0..4].to_f #)
        array_of_clean_data = [name, concentration, race, year, data]
      end
    end
    binding.pry
      #iterate through @data (cleaned data) when sanitation is working
      #find district name --   # find_by_name(district_name)

        #1. district name doesn't exist
          # create district.new
        #2. district name DOES exist
          # create enrollment via enrollment respository.load_data(cleaned_data)


        #3 --not here? --- link district name to enrollment object with find_by_na

      #=====================
    #     if districts[line[:location].upcase]
    #       if name == :kindergarten
    #         districts[line[:location].upcase].enrollment_data[line[:timeframe].to_i] = line[:data][0..4].to_f
    #       elsif name == :high_school_graduation
    #         districts[line[:location].upcase].graduation_data[line[:timeframe].to_i] = line[:data][0..4].to_f
    #       # end
    #     else
    #       if name == :kindergarten
    #         districts[line[:location].upcase] = District.new({name: line[:location].upcase, enrollment_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
    #       elsif name == :high_school_graduation
    #         districts[line[:location].upcase] = District.new({name: line[:location].upcase, graduation_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
    #       end
    #     end
    #   end
    # end
    # if input.keys.include?(:statewide_testing)
    #   statewide_instance.load_data(input)
    # end


    #==========================
    #iterate through @data (cleaned data)
    #find district name --   # find_by_name(district_name)

      #1. district name doesn't exist
        # create district.new
      #2. district name DOES exist
        # create enrollment via enrollment respository.load_data(cleaned_data)


      #3 --not here? --- link district name to enrollment object with find_by_name

    ##derp_1 first try at load data
    #=============================================================
    # enrollment_instance.load_data(input)
    # input[:enrollment].each do |name, value|
    #   file = input[:enrollment][name]
    #   data = CSV.open(file, headers: true, header_converters: :symbol)
    #   data.each do |line|
    #     if districts[line[:location].upcase]
    #       if name == :kindergarten
    #         districts[line[:location].upcase].enrollment_data[line[:timeframe].to_i] = line[:data][0..4].to_f
    #       elsif name == :high_school_graduation
    #         districts[line[:location].upcase].graduation_data[line[:timeframe].to_i] = line[:data][0..4].to_f
    #       # end
    #     else
    #       if name == :kindergarten
    #         districts[line[:location].upcase] = District.new({name: line[:location].upcase, enrollment_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
    #       elsif name == :high_school_graduation
    #         districts[line[:location].upcase] = District.new({name: line[:location].upcase, graduation_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
    #       end
    #     end
    #   end
    # end
    # if input.keys.include?(:statewide_testing)
    #   statewide_instance.load_data(input)
    # end
  end

  # def find_by_name(district_name)
  #   districts[district_name]
  #   #this returns district object
  #   #districts needs to change t oreflect the fact district_repository
  #   ## district object = dr.find _by_name(district_name)
  # end
  #
  # def find_all_matching(input)
  #   matches = districts.find_all do |district|
  #     district[0].include?(input.upcase)
  #   end
  #   matches
  # end
  #
  # def find_enrollment(name)
  #   enrollment_instance.find_by_name(name)
  #   # enrollment object = er.find_by_name(district_name)
  #   #change enrollment repoisitory
  # end
  #
  # def find_statewide_test(name)
  #   statewide_instance.find_by_name(name)
  #   # statewidetest object = statewidetest.find_by_name(district_name)
  #   #change statewidetest_instance to repoisitory
  #
  # end
end


####derp######




      # do you need to initialize in init and add to attr?
      #@hash_of_files.each_key {|key| :key}
      #does each key need to be a symbol, isn't it already a symbol
      #====================================
      #is Sanitation going to be a module?
    #has keys and values
      #that makes years.to_i, data.to_f and ignores if n/a or else or 0, names.upcase
      #Sanitation does csv.open  and sends back @data with cleaned data

    #===========================

# #take hash_of_files and, make keys, send symbols to new hash
#   array_of_files = input[:enrollment].values
#   @opened_file = array_of_files.each do |file| #don't use each
#     #Sanitation.open_files(original_files)
#     CSV.open(file, headers: true, header_converters: :symbol)
#
#     #Sanitation.make_values_useable(file)
#
#   end
#   @cleaned_file = file.map do |line|
#     binding.pry
#     #@line = (
#     @name = line[:location].upcase
#     @concentration = line[:score] unless :score == nil
#     @race = line[:race_ethnicity] unless :race_ethnicity == nil
#     @year = line[:timeframe].to_i
#     @data = line[:data][0..4].to_f #)
#
#     return line
#   end
#   return @cleaned_file
# #binding.pry
