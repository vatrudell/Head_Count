class District
  attr_accessor :name,
                :d_repo,
                :enrollment_link,
                :statewide_test_link

  def initialize(name, d_repo = false)
    @name =  name
    @d_repo = d_repo
    @enrollment_link = enrollment_link
    @statewide_test_link = statewide_test_link
  end

  def enrollment
      #binding.pry
      d_repo.find_enrollment(name)
  end

  def statewide_test
    d_repo.find_statewide_test(name)
  end
end
