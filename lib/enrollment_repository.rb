require 'csv'
require './lib/enrollment'
require 'pry'

class EnrollmentRepository
  attr_accessor :enrollments
  def initialize
    @enrollments = {}
  end

  def load_data({:enrollment => :kindergarten => nil, :high_school_graduation => nil})
    kindergarten = input[:enrollment][:kindergarten]
    highschool = input[:enrollment][:high_school_graduation]
    #binding.pry
    #file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    #@data = CSV.open(file, headers: true, header_converters: :symbol)

  end

  def populate_data #kindergarten
    @data.each do |line|
      if @enrollments[line[:location].upcase]
        @enrollments[line[:location].upcase].kindergarten_participation[line[:timeframe].to_i] = line[:data][0..4].to_f
        binding.pry
      else
        @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, kindergarten_participation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
      end
    end
  end



  def find_by_name(district_name)
    @enrollments[district_name]
  end
end


er = EnrollmentRepository.new
er.load_data({
         :enrollment => {
           :kindergarten => "./data/Kindergartners in full-day program.csv",
           :high_school_graduation => "./data/High school graduation rates.csv"
         }
       })
enrollment = er.find_by_name("ACADEMY 20")
