class StateWideTest
  attr_accessor :grade_three_proficient,
                :grade_eight_proficient,
                :average_proficiency,
                :proficient_by_grade

  def initialize(input)
    @name = input[:name]
    @grade_three_proficient = input[:grade_three_proficient]
    @grade_eight_proficient = Hash.new(0)
    @average_proficiency = Hash.new(0)
  end

  def proficient_by_grade(grade)
    grades = [3, 8]
    if grades.include?(grade)
      if grade == 3
        @grade_three_proficient
      else grade == 8
        @grade_eight_proficient
      end
    else
      "UnknownDataError"
    end
  end

  def proficient_by_race_or_ethnicity(race)
    races = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    if races.include? race
      @average_proficiency[race]
    else
      "UnknownDataError"
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    subjects = [:math, :reading, :writing]
    grades = [3, 8]
    years = [2008, 2009, 2010, 2011, 2012, 2013, 2014]
    if subjects.include?(subject) && grades.include?(grade) && years.include?(year)
      proficient_by_grade(grade)[year][subject]
    else
      "UnknownDataError"
    end
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    subjects = [:math, :reading, :writing]
    races = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    years = [2011, 2012, 2013, 2014]
    if subjects.include?(subject) && races.include?(race) && years.include?(year)
      return proficient_by_race_or_ethnicity(race)[year][subject]
    else
      return "UnknownDataError"
    end
  end
end
