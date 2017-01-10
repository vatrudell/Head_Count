require 'csv'
require 'pry'
require './lib/district'
require './lib/enrollment_repository'



class DistrictRepository
  attr_accessor :districts,
                :enrollment_instance,
                :file,
                :find_enrollment

  def initialize
    @districts = {}
    @enrollment_instance = EnrollmentRepository.new
  end

  def load_data(input)
    input[:enrollment].each do |name, value|
      file = input[:enrollment][name]
    @data = CSV.open(file, headers: true, header_converters: :symbol)
      @data.each do |line|
        if @districts[line[:location].upcase]
          if name == :kindergarten
            @districts[line[:location].upcase].enrollment_data[line[:timeframe].to_i] = line[:data][0..4].to_f
          elsif
            name == :high_school_graduation
            @districts[line[:location].upcase].graduation_data[line[:timeframe].to_i] = line[:data][0..4].to_f
          end
        else
          if name == :kindergarten
            @districts[line[:location].upcase] = District.new({name: line[:location].upcase, enrollment_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
          elsif name == :high_school_graduation
            @districts[line[:location].upcase] = District.new({name: line[:location].upcase, graduation_data: {line[:timeframe].to_i => line[:data][0..4].to_f}}, self)
          end
        end
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
    # dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv",
    #                               :high_school_graduation => "./data/High school graduation rates.csv"}})
