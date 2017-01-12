require 'pry'

class District
  attr_accessor :name,
                :dr,
                :enrollment_data,
                :graduation_data

  def initialize(district, dr = false)
    @name =  district[:name]
    @dr = dr
    @enrollment_data = district[:enrollment_data]
    @graduation_data = Hash.new(0)
  end

  def enrollment
    dr.find_enrollment(name)
  end

  def statewide_test
    dr.find_statewide_test(name)
  end
end
