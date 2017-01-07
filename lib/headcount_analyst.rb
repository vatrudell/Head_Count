class HeadcountAnalyst
  def initialize
    @enrollment_repository = EnrollmentRepository.new
    @district_repository = DistrictRepository.new(@enrollment_repository)
  end

end



@enrollment_repository.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
kek = @enrollment_repository.find_by_name("GUNNISON WATERSHED RE1J")
#binding.pry
# puts @enrollment_repository.find_all_matching("WE").count
kek.enrollment.kindergarten_participation_in_year(2004)

# er = EnrollmentRepository.new
er.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }
})
