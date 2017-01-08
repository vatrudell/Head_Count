class District
  attr_accessor :name,
              :dr,
              :enrollment_data
  def initialize(district, dr = nil)
    # @district = district
    @name =  district[:name]
    @dr = dr
    @enrollment_data = district[:enrollment_data]
  end

  def enrollment
    @dr.find_enrollment(@name)
  end

    
end
