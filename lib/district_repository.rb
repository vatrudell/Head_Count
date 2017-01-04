require 'csv'
require 'pry'


class DistrictRepository
  # attr_accessor :location,
  #               :timeframe,
  #               :dataformat,
  #               :data
  #
  def initialize
    #@whole_processed_file = whole_processed_file
  end
  #

  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    data = CSV.open(file, :headers => true, :header_converters => :symbol)
    @whole_processed_file = data.map do |line|
      line
    end
    #puts @whole_processed_file[0]


  end

  #binding.pry
  def find_by_name(district_name)
    @whole_processed_file.find_all do |line|
      if line[0] == district_name
        puts line
      end
    end
  end
end

# derp = DistrictRepository.new
# puts derp.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })

derp = DistrictRepository.new
derp.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
derp.find_by_name("ACADEMY 20")
