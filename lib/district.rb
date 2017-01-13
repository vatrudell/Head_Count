require 'pry'

class District
  attr_accessor :name,
                :dr,
                :enrollment_data,
                :graduation_data

  def initialize(district, dr = false)
    @name =  district[:name]
    @dr = dr
    # @enrollment_data = district[:enrollment_data]
    # @graduation_data = Hash.new(0)
    #below will be here, above will not
    # district_object_enrollment_link = enrollment_object
    #
    # district_object_statewidetest_link = statewidetest_object
  end

  def enrollment
    dr.find_enrollment(name)
  end

  def statewide_test
    dr.find_statewide_test(name)
  end
end
