require 'pry'
require_relative '../lib/district'
require_relative '../lib/enrollment_repository'
require_relative '../lib/statewide_test_repository'
require_relative '../lib/sanitation'

class DistrictRepository
  include Sanitation
  attr_accessor :district_repository,
                :enrollment_repository,
                :statewide_test_repository,
                :districts



  def initialize
    @districts = {}
    @enrollment_repository = EnrollmentRepository.new

  end

  def load_data(input)
    clean_up_district(input)
    populate_district_data(input)
    #enrollment_repository.load_data(input)
    # load_other_repository_data(input)
  end

  def populate_district_data(input)
    @enrollment_repository.load_data(input)
    binding.pry
    # if districts.keys.include?(@name)
    #   # enrollment_repository.load_data(input)
    #
    #   # districts[@name].name = @name
    #   @enrollment_link = find_enrollment(@name) #
    #   binding.pry
    # else
    #   districts[@name] = District.new(@name, self)
    # end
  end

  def load_other_repository_data(input)
    if input.keys.include?(:statewide_testing)
      statewide_test_repository = StatewideTestRepository.new
      statewide_test_repository.load_data(input)
    end
  end

  def test_shit

    binding.pry
  end
end










#
#       if district_repository[name_in_line]  #.nil?  #put find_all_matching #need to ask if dis. object exists
#         district_repository[name_in_line] = District.new(name_in_line, self)
#       else
#         puts "poop"
#         enrollment_repository.load_data(hash_of_clean_data)
#         #@enrollment_link = enrollment_repository.find_by_name(name_in_line)
#       end
#     end
#   end
#
#   def find_by_name(district_name)
#     if district_repository.include?(district_name)
#       district_repository[district_name]
#     else
#       "You entered a district name that doens't exists!"
#     end
#   end
#
#   def find_all_matching(input)
#     matches = district_repository.find_all do |district|
#       district[0].include?(input.upcase)
#     end
#     matches
#   end
#
#   def find_enrollment(name)
#     enrollment_repository.find_by_name(name)
#     # enrollment object = er.find_by_name(district_name)
#     #change enrollment repoisitory
#   end
#
#   def find_statewide_test(name)
#     statewide_test_repository.find_by_name(name)
#     # statewidetest object = statewidetest.find_by_name(district_name)
#     #change statewidetest_instance to repoisitory
#   end
# end

        #3 --not here? --- link district name to enrollment object with find_by_na

    # if input.keys.include?(:statewide_testing)
    #   statewide_instance.load_data(input)
    # end



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
