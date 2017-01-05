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
    @districts = data.map do |line|
      # anything here
      District.new({name: line[:location]})
    end
  end

  def find_by_name(district_name)
    @districts.find do |district|
      #binding.pry
      district == district_name
      district
    end
  end
end

derp = DistrictRepository.new
derp.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
derp.find_by_name("ACADEMY 20")
