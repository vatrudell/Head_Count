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
          @district_name = line[:location].upcase
          @year = line[:timeframe].to_i

            if line[:score] == "Math"
              @concentration = :math
            elsif line[:score] == "Writing"
              @concentration = :writing
            elsif line[:score] == "Reading"
              @concentration = :reading
            end

            if line[:data].nil?
              @district_data =  "N/A"
            else
              @district_data =  (line[:data][0..4].to_f)
            end

            if line[:race_ethnicity] == "All Students"
              @race = :all_students
            elsif line[:race_ethnicity] == "Asian"
              @race = :asian
            elsif line[:race_ethnicity] == "Black"
              @race = :black
            elsif line[:race_ethnicity] == "Hawaiian/Pacific Islander"
              @race = :pacific_islander
            elsif line[:race_ethnicity] == "Hispanic"
              @race = :hispanic
            elsif line[:race_ethnicity] == "Native American"
              @race = :native_american
            elsif line[:race_ethnicity] == "Two or more"
              @race = :two_or_more
            elsif line[:race_ethnicity] == "White"
              @race = :white
            end
          
            
          if @statewide_information.keys.include? @district_name.upcase
            if name == :third_grade
              if @statewide_information[@district_name.upcase].grade_three_proficient.has_key? @year
                new_statewide = {}
                new_statewide[@concentration] = @district_data
                @statewide_information[@district_name.upcase].grade_three_proficient[@year].merge!(new_statewide)
              else 
                @statewide_information[@district_name.upcase].grade_three_proficient.store(@year, {@concentration => @district_data})
              end 
            elsif name == :eighth_grade
              if @statewide_information[@district_name.upcase].grade_eight_proficient.has_key? @year
                new_statewide = {}
                new_statewide[@concentration] = @district_data
                @statewide_information[@district_name.upcase].grade_eight_proficient[@year].merge!(new_statewide)
              else 
                @statewide_information[@district_name.upcase].grade_eight_proficient.store(@year, {@concentration => @district_data})
              end
            elsif name == :math
              if @statewide_information[@district_name.upcase].average_proficiency.has_key? @race
                if @statewide_information[@district_name.upcase].average_proficiency[@race].has_key? @year
                  new_statewide = {}
                  new_statewide[name] = @district_data
                  @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
                else
                  new_statewide = {}
                  new_statewide[@year] = {name => @district_data}
                  @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
                end
              else
              @statewide_information[@district_name.upcase].average_proficiency.store(@race, {@year => {name => @district_data}})
              end
            elsif name == :reading
              if @statewide_information[@district_name.upcase].average_proficiency.has_key? @race
                if @statewide_information[@district_name.upcase].average_proficiency[@race].has_key? @year
                  new_statewide = {}
                  new_statewide[name] = @district_data
                  @statewide_information[@district_name.upcase].average_proficiency[@race][@year].merge!(new_statewide)
                else
                  new_statewide = {}
                  new_statewide[@year] = {name => @district_data}
                  @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
                end
              else
                @statewide_information[@district_name.upcase].average_proficiency.store(@race, {@year => {name => @district_data}})
                  new_statewide = {}
                  new_statewide[name] = @district_data
                  @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
              end
            elsif name == :writing
              if @statewide_information[@district_name.upcase].average_proficiency.has_key? @race
                if @statewide_information[@district_name.upcase].average_proficiency[@race].has_key? @year
                  new_statewide = {}
                  new_statewide[name] = @district_data
                  @statewide_information[@district_name.upcase].average_proficiency[@race][@year].merge!(new_statewide)
                else
                  new_statewide = {}
                  new_statewide[@year] = {name => @district_data}
                  @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide) 
                end
              else
                @statewide_information[@district_name.upcase].average_proficiency.store(@race, {@year => {name => @district_data}})
                  new_statewide = {}
                  new_statewide[name] = @district_data
                  @statewide_information[@district_name.upcase].average_proficiency[@race].merge!(new_statewide)
              end
            end
          elsif name == :third_grade  
            @statewide_information[@district_name.upcase] =  StatewideTest.new({:name => @district_name, :grade_three_proficient => {@year => {@concentration => @district_data}}})      
          end  
        end  
      end
    end 

    def find_by_name(district)
      @statewide_information[district]
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
    str.find_by_name("ACADEMY 20")
    abalone = str.find_by_name("ACADEMY 20")
    abalone.proficient_by_grade(3)
    abalone.proficient_by_race_or_ethnicity(:white)
    abalone.proficient_for_subject_by_grade_in_year(:math, 8, 2010)
    abalone.proficient_for_subject_by_race_in_year(:math, :asian, 2011)