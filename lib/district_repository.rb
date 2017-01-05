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
      District.new({name: line[:location]})
    end
  end

  def find_by_name(district_name)
    @districts.find do |district|
      if district.name == district_name
        district
      end
    end
  end

  def find_all_matching(input)
    matches = @districts.find_all do |district|
      district.name.include?(input.upcase)
    end
    ##figure out how to make out reoccurances in matches
    ##below doesn't work
    matches.delete_if do |district|
      matches.include?(district)
    end
    matches
    binding.pry
  end
end

derp = DistrictRepository.new
derp.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
#derp.find_by_name("ACADEMY 20")
puts derp.find_all_matching("WE").count
