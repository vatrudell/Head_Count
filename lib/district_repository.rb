require 'pry'
require_relative '../lib/district'
require_relative '../lib/enrollment_repository'
require_relative '../lib/statewide_test_repository'
require_relative '../lib/economic_profile_repository'
require_relative '../lib/sanitation'
require_relative '../lib/economic_profile_repository'


class DistrictRepository
  include Sanitation
  attr_accessor :district_repository,
                :enrollment_repository,
                :statewide_test_repository,
                :economic_repository,
                :districts

  def initialize
    @districts = {}
    @enrollment_repository = EnrollmentRepository.new
    @statewide_test_repository = StatewideTestRepository.new
    @economic_repository = EconomicProfileRepository.new

  end

  def load_data(input)
    clean_up_district_data(input)
    @enrollment_repository.load_data(input) if input.include?(:enrollment)
    @statewide_test_repository.load_data(input) if input.include?(:statewide_testing)
    @economic_repository.load_data(input) if input.include?(:economic_profile)
  end

  def populate_district_data
    if districts.keys.include?(@name)
      districts[@name].name = @name
    else
      districts[@name] = District.new({
        name: @name}, self)
    end
  end

  def find_by_name(district_name)
    if districts.include?(district_name)
      districts[district_name]
    else
      "You entered a district name that doens't exists!"   #put in raise args error
    end
  end
  # and if name is invalid

  def find_all_matching(input)
    matches = districts.find_all do |district|
      district[0].include?(input)
    end
    matches
  end

  #error for mathches is 0  input is invalid

  def find_enrollment(name)
    enrollment_repository.find_by_name(name)
  end

  #error for invalid input

  def find_statewide_test(name)
    statewide_test_repository.find_by_name(name)
  end
  
  #error for invalid input
  def find_economic(name)
    economic_repository.find_by_name(name)
  end
end
