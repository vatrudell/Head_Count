require 'csv'
require 'pry'
require './lib/district'


class DistrictRepository
  def initialize
    @districts = {}
  end

  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    data = CSV.open(file, headers: true, header_converters: :symbol)
    data.each do |line|
      @districts[line[:location]] = District.new({name: line[:location]})
    end
  end

  def find_by_name(district_name)
    @districts.find do |district|
      if district[0] == district_name
        district
      end
    end
  end

  def find_all_matching(input)
    matches = @districts.find_all do |district|
      district[0].include?(input.upcase)
    end
    matches
  end
end

derp = DistrictRepository.new
derp.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
derp.find_by_name("ACADEMY 20")
puts derp.find_all_matching("WE").count
