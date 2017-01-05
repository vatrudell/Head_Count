require 'pry'
class District
  attr_reader :name
  def initialize(name)
    #binding.pry
    @name =  name[:name]
  end
end
