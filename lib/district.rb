class District
  attr_accessor :name,
                :district_repo

  def initialize(name, d_repo = false)
    @name =  name
    @district_repo = d_repo
  end

  def enrollment
      district_repo.find_enrollment(name)
  end

  def statewide_test
    district_repo.find_statewide_test(name)
  end
end
