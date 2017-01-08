require 'csv'
require './lib/enrollment'
require 'pry'

class EnrollmentRepository
  attr_accessor :enrollments
  def initialize
    @enrollments = {}
  end

  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    @data = CSV.open(file, headers: true, header_converters: :symbol)
    populate_data
  end

  def populate_data
    @data.each do |line|
      if @enrollments[line[:location]]
        @enrollments[line[:location]].kindergarten_participation[line[:timeframe].to_i] = line[:data][0..4].to_f
      else
        @enrollments[line[:location]] = Enrollment.new({name: line[:location], kindergarten_participation: {line[:timeframe].to_i => line[:data][0..4].to_f}})

      end
    end
    #binding.pry
  end

  def find_by_name(district_name)
    @enrollments[district_name]
  end
end


# er = EnrollmentRepository.new
# er.load_data({
#          :enrollment => {
#            :kindergarten => "./data/Kindergartners in full-day program.csv"
#          }
#        })
# puts er.find_by_name("ACADEMY 20")

#
#
# er.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })
# enrollment = er.find_by_name("ACADEMY 20")
