require 'csv'
require 'pry'

class DistrictRepository
  def load_data(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    data = CSV.open(file, :headers => true, :header_converters => :symbol)
  end

  def find_by_name(district_name)
    "I don't fucking know"
    #have questions on this
    #
  end
end

# derp = DistrictRepository.new
# puts derp.load_data({
#   :enrollment => {
#     :kindergarten => "./data/Kindergartners in full-day program.csv"
#   }
# })
