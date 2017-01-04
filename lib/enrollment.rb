class Enrollment
  def initialize

  end

  def kindergarten_participation_by_year(year)
    if ![:year].include?(year) #need to read file, and load data.
      return nil
    end

    #here we will look in Kindergartners in full-day program.csv
    # link year to percentage by
    # finding input year in :year
    #add total percentage for each year
  end
end
