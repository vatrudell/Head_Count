require 'csv'
require 'pry'
require './lib/district'
require './lib/enrollment_repository'




class DistrictRepository
  attr_reader :districts,
              :enrollment_instance,
              :file

  def initialize
    @districts = {}
    @enrollment_instance = EnrollmentRepository.new
  end

  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    @file = CSV.open(file, headers: true, header_converters: :symbol)
    @enrollment_instance.load_data(input)
    populate_data
  end


  def populate_data
    @file.each do |line|
      if @districts[line[:location].upcase]
        @districts[line[:location].upcase].enrollment_data[line[:timeframe].to_i] = line[:data][0..4].to_f
      else
        @districts[line[:location].upcase] = District.new({name: line[:location].upcase, enrollment_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
        #binding.pry
      end
    end
  end

  def find_by_name(district_name)
    @districts[district_name]
  end

  def find_all_matching(input)
    matches = @districts.find_all do |district|
      district[0].include?(input.upcase)
    end
    matches
  end

  def find_enrollment(name)
    @enrollment_instance.find_by_name(name)
  end
end


# dr = DistrictRepository.new
# dr.load_data({
#                :enrollment => {
#                  :kindergarten => "./data/Kindergartners in full-day program.csv"
#                }
#              })
# puts dr.find_by_name("ACADEMY 20")
