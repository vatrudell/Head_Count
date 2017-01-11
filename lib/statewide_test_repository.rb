require 'csv'
require './lib/statewide_test'
require 'pry'

class StatewideTestRepository
  attr_accessor :statewide_information
  def initialize
    @statewide_information = Hash.new(0)
  end

 def load_data(input)     
    input[:statewide_testing].each do |name, value| 
  
      file = input[:statewide_testing][name]
      @data = CSV.open(file, headers: true, header_converters: :symbol)
      @data.each do |line|  
        @district_name = line[:location] 
        @concentration = line[:score] 
        @year = line[:timeframe] 
        @district_data =  line[:data]
        @race = line[:raceethnicity]
          
        if @statewide_information.keys.include? @district_name.upcase
          # binding.pry
          if name == :third_grade 
            if @statewide_information[@district_name.upcase].grade_three_proficient.has_key? @year
              new_statewide = {}
              new_statewide[@concentration] = @district_data
              @statewide_information[@district_name.upcase].grade_three_proficient[@year].merge!(new_statewide)
            else 
              @statewide_information[@district_name.upcase].grade_three_proficient.store(@year, {@concentration => @district_data})     #[@year] = {@concentration => @district_data}
            end 
          elsif name == :eighth_grade
            if @statewide_information[@district_name.upcase].grade_eight_proficient.has_key? @year
              new_statewide = {}
              new_statewide[@concentration] = @district_data
              @statewide_information[@district_name.upcase].grade_eight_proficient[@year].merge!(new_statewide)
            else 
              @statewide_information[@district_name.upcase].grade_eight_proficient.store(@year, {@concentration => @district_data})
            end
          # elsif name == :average_proficiency_by_ethnicity_math
          #   if @statewide_information[@district_name.upcase].average_proficiency_by_ethnicity_math.has_key? @race
          #     new_statewide = {}
          #     new_statewide[@

          end

        elsif name == :third_grade  
          @statewide_information[@district_name.upcase] =  StatewideTest.new({:name => @district_name, :grade_three_proficient => {@year => {@concentration => @district_data}}})      
        elsif name == :eighth_grade 
          @statewide_information[name] = StatewideTest.new({:name => @district_name, :grade_eight_proficient => {@year => {@concentration => @district_data}}})
        elsif name == :math
          @statewide_information[name] = StatewideTest.new({:name => @district_name, :average_proficiency_by_ethnicity_math => {@ethnicity =>{@year =>{@concentration => @district_data}}}})
        end  
      
    
      end  
      # binding.pry
    end
    binding.pry
  end 
end

 



        

str = StatewideTestRepository.new
    str.load_data({
                    :statewide_testing => {
                      :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                      # :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                      # :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                    }
                  })