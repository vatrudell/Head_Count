require 'csv'
require './lib/enrollment'
require 'pry'

class EnrollmentRepository
  attr_accessor :enrollments,
                :data_tag,
                :data
  def initialize
    @enrollments = {}
  end

 def load_data(input)
  input[:enrollment].each do |name, value|
      file = input[:enrollment][name]
      @data = CSV.open(file, headers: true, header_converters: :symbol)
        @data.each do |line|
          if @enrollments[line[:location].upcase]
            if name == :kindergarten
              @enrollments[line[:location].upcase].kindergarten_participation[line[:timeframe].to_i] = line[:data][0..4].to_f
            elsif
              name == :high_school_graduation
              @enrollments[line[:location].upcase].high_school_graduation[line[:timeframe].to_i] = line[:data][0..4].to_f
            end
          else
            if name == :kindergarten
              @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, kindergarten_participation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            elsif name == :high_school_graduation
              @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, high_school_graduation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            end
          end
        end
      end
    # binding.pry
  end

  def find_by_name(district_name)
    @enrollments[district_name]
  end

end

# er = EnrollmentRepository.new
# er.load_data({
#          :enrollment => {
#            :kindergarten => "./data/Kindergartners in full-day program.csv",
#            :high_school_graduation => "./data/High school graduation rates.csv"
#          }
#        })

# e = er.find_by_name("COLORADO")
# e.graduation_rate_by_year
