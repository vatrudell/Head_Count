


input.values.each do|name, data|
  if name = :kindergarten
      file = input[:enrollment][:kindergarten]
      @data_tag = kindergarten_participation
      populate_data
  elsif name = :high_school_graduation
      file = input[:enrollment][:high_school_graduation]
      @data_tag = high_school_graduation_rate
      populate_data
  end

end
def load_data(input)
  input[:enrollment].each do |name, value|
      file = input[:enrollment][name]
      @data = CSV.open(file, headers: true, header_converters: :symbol)
        @data.each do |line|
          if @enrollments[line[:location].upcase]
            if name == :kindergarten
              @enrollments[line[:location].upcase].kindergarten_participation[line[:timeframe].to_i] = line[:data][0..4].to_f
            elsif
              name == :high_school_graduation
              @enrollments[line[:location].upcase].high_school_graduation[line[:timeframe].to_i] = line[:data][0..4].to_f
            end
          else
            if name == :kindergarten
              @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, kindergarten_participation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            elsif name == :high_school_graduation
              @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, high_school_graduation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            end
          end
        end
      end
    end
  end


 def load_data(input)
    
    # kindergarten = input[:enrollment][:kindergarten]
    # highschool = input[:enrollment][:high_school_graduation]
    # file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there
    input[:enrollment].each do |name, value|
      if name == :kindergarten
        file = input[:enrollment][:kindergarten]
        # @data_tag = "kindergarten_participation"
        @data = CSV.open(file, headers: true, header_converters: :symbol)
        # binding.pry
          @data.each do |line|
          if @enrollments[line[:location].upcase]
            @enrollments[line[:location].upcase].kindergarten_participation[line[:timeframe].to_i] = line[:data][0..4].to_f
          else
            @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, kindergarten_participation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
          end
        end
      elsif name == :high_school_graduation
        file = input[:enrollment][:high_school_graduation]
        # @data_tag = "high_school_graduation_rate"
        @data = CSV.open(file, headers: true, header_converters: :symbol)
          @data.each do |line|
          
            if @enrollments[line[:location].upcase]
              @enrollments[line[:location].upcase].high_school_graduation[line[:timeframe].to_i] = line[:data][0..4].to_f
              binding.pry
            else
              @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, high_school_graduation: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            end
            
          end
       
      else
        puts "Fuck"
      end
      # binding.pry
    end
  end


def populate_data #kindergarten
    @data.each do |line|
      if @enrollments[line[:location].upcase]
        @enrollments[line[:location].upcase].data_tag[line[:timeframe].to_i] = line[:data][0..4].to_f
      else
        @enrollments[line[:location].upcase] = Enrollment.new({name: line[:location].upcase, data_tag: {line[:timeframe].to_i => line[:data][0..4].to_f}})
      end
    end
  end





 def kindergarten_participation_against_high_school_graduation(district)
  data_to_math << @enrollments[district].kindergarten_participation.values
  data_to_math << @enrollments[district].high_school_graduation.values
  
  count = 0
  data_to_math.each do |data|
    sum = data.reduce(0) do |sum, number|
     count += 1
      totals << (sum + number)
    end
  end
    average = totals[0]/totals[1]
    average
  end


  def math(district)
    
    count = 0
    sum = district.reduce(0) do |sum, number|
        count += 1
        sum + number
    end
    average = sum/count
    average
  end

def kindergarten_participation_against_high_school_graduation(district)
one = math_two(@input.districts[district].enrollment_data.values)
two = math_two(@input.districts[district].graduation_data.values)

result = (one*1000)/(two*1000)
    result.round(3)
end

end



class StatewideTestRepository
  attr_accessor :enrollments,
                :data_tag,
                :data
  def initialize
    @statewide_testing = {}
  end

 def load_data(input)
  input[:statewide_testing].each do |name, value|
      file = input[:statewide_testing][name]
      @data = CSV.open(file, headers: true, header_converters: :symbol)
        @data.each do |line|
          if @statewide_testing[line[:location].upcase]
            if name == :third_grade
              @statewide_testing[line[:location].upcase].grade_three_proficient[line[:timeframe].to_i] = line[:data][0..4].to_f
            elsif name == :eighth_grade
              @statewide_testing[line[:location].upcase].grade_eight_proficient[line[:timeframe].to_i] = line[:data][0..4].to_f
            elsif name == :math
              @statewide_testing[line[:location].upcase].average_proficiency_by_ethnicity_math[line[:timeframe].to_i] = line[:data][0..4].to_f
            elsif name == :reading
              @statewide_testing[line[:location].upcase].average_proficiency_by_ethnicity_reading[line[:timeframe].to_i] = line[:data][0..4].to_f
            elsif name == :writing
              @statewide_testing[line[:location].upcase].average_proficiency_by_ethnicity_writing[line[:timeframe].to_i] = line[:data][0..4].to_f
            end
          else
            if name == :third_grade
              @statewide_testing[line[:location].upcase] = StatewideTest.new({name: line[:location].upcase, grade_three_proficient: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            elsif name == :eighth_grade
              @statewide_testing[line[:location].upcase] = StatewideTest.new({name: line[:location].upcase, grade_eight_proficient: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            elsif name == :math
              @statewide_testing[line[:location].upcase] = StatewideTest.new({name: line[:location].upcase, average_proficiency_by_ethnicity_math: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            elsif name == :reading
              @statewide_testing[line[:location].upcase] = StatewideTest.new({name: line[:location].upcase, average_proficiency_by_ethnicity_reading: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            elsif name == :writing
              @statewide_testing[line[:location].upcase] = StatewideTest.new({name: line[:location].upcase, average_proficiency_by_ethnicity_writing: {line[:timeframe].to_i => line[:data][0..4].to_f}})
            end
  
          end
        end
      end
  end

  def find_by_name(district_name)
    @enrollments[district_name]
  end

end

str = StatewideTestRepository.new
    str.load_data({
                    :statewide_testing => {
                      :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                      :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                      :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                    }
                  })




      binding.pry 
      @statewide_information.keys.each do |key|
    
        @grade_three_proficient if name == :third_grade
        @grade_eight_proficient if name == :eighth_grade