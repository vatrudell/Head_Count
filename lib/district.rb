class District
  attr_accessor :name,
                :district_repo

  def initialize(name, district_repo = false)
    @name =  name
    @district_repo = district_repo
  end

  def enrollment
      district_repo.find_enrollment(name)
  end

  def statewide_test
    district_repo.find_statewide_test(name)
  end
  
  def economic_repository
    district_repo.find_economic(name)
  end
end
