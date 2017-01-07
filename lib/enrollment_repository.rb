require 'csv'
require './lib/enrollment'
require 'pry'

class EnrollmentRepository
  def initialize
    @enrollments = {}
  end

  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    data = CSV.open(file, headers: true, header_converters: :symbol)
    data.each do |line|
      if @enrollments[line[:location]]
        @enrollments[line[:location]].kindergarten_participation[line[:timeframe]] = line[:data]
      else
        @enrollments[line[:location]] = Enrollment.new({name: line[:location], kindergarten_participation: {line[:timeframe] => line[:data]}})
      end
    end
  end

  def find_by_name(district_name)
    @enrollments[district_name]
  end
end







# er = EnrollmentRepository.new
# er.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })
# enrollment = er.find_by_name("ACADEMY 20")
