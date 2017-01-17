class District
  attr_accessor :name,
                :d_repo

  def initialize(name, d_repo = false)
    @name =  name
    @d_repo = d_repo
  end

  def enrollment
    d_repo.find_enrollment(name)
  end

  def statewide_test
    d_repo.find_statewide_test(name)
  end

  def economic_repository
    d_repo.find_economic(name)
  end
end
