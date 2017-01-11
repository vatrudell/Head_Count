

class StatewideTest
  attr_reader :grade_three_proficient,
                :grade_eight_proficient,
                :average_proficiency_by_ethnicity_math,
                :average_proficiency_by_ethnicity_reading,
                :average_proficiency_by_ethnicity_writing

  def initialize(input)
    @name = input[:name]
    @grade_three_proficient = input[:grade_three_proficient]
    @grade_eight_proficient = Hash.new(0)
    @average_proficiency_by_ethnicity_math = Hash.new(0)
    # @average_proficiency_by_ethnicity_reading = Hash.new(0)
    # @average_proficiency_by_ethnicity_writing = Hash.new(0)
  end

end