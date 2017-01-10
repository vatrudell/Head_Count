


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




  # def math(district)
  #   data_values = @input.districts[district].enrollment_data.values
  #   count = 0
  #   sum = data_values.reduce(0) do |sum, number|
  #       count += 1
  #       sum + number
  #   end
  #   average = sum/count
  #   average
  # end
