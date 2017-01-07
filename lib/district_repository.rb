require 'csv'
require 'pry'
require './lib/district'
require './lib/enrollment_repository'



class DistrictRepository
  def initialize   #(enrollment_repository)
    @districts = {}
    @enrollment_instance = EnrollmentRepository.new  #enrollment_repository
  end

  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    data = CSV.open(file, headers: true, header_converters: :symbol)
    @enrollment_instance.load_data(input)
    data.each do |line|
      @districts[line[:location]] = District.new({name: line[:location]}, self)
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

  def enrollment(name)
    @enrollment_instance.find_by_name(name)

  end
  #binding.pry
end


new = DistrictRepository.new
new.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
kek = new.find_by_name("ACADEMY 20")
#binding.pry
# puts @enrollment_repository.find_all_matching("WE").count
puts kek.enrollment.kindergarten_participation_in_year(2010)

# er = EnrollmentRepository.new
# er.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })
