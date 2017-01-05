require 'pry'
class District
  attr_reader :name
  def initialize(name)
    #binding.pry
    @name =  name[:name]
  end

  # def name
  #   @input.values.pop.upcase
  # end


end
