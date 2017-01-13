require 'csv'
require 'pry'
#you can't have each file requirering each other
#require './lib/district_repository'

module Sanitation
  #this is what is send here
  #sanitation(hash_of_files) #has keys and values
    #that makes years.to_i, data.to_f and ignores if n/a or else or 0, names.upcase
    #Sanitation does csv.open  and sends back @data with cleaned data
  attr_reader :line,
              :name,
              :concentration,
              :race,
              :year,
              :data,
              :cleaned_files

  def initialize
    #@cleaned_files = Array.new
    #@opened_file = open_file
    #@data = data
  end

  # def self.open_files(original_files) #as a hash value is file
  #   binding.pry
  # end

  #def self.make_values_useable(original_file)
  #   #below doesn't work
  #   # original_files.each do |file| #don't use each
  #   #   #Sanitation.open_files(original_files)
  #   #   @opened_file = CSV.open(file, headers: true, header_converters: :symbol)
  #   # end
  #   @cleaned_file = original_file.tap do |line|
  #     binding.pry
  #     #@line = (
  #             
  #
  #     return line
  #   end
  #   return @cleaned_file
  #   binding.pry
  # end
end


 #districts[line[:location].upcase] = District.new({name:
 #line[:location].upcase, enrollment_data: {line[:timeframe].to_i =>
 #line[:data][0..4].to_f}}, self)
# Location,               TimeFrame,DataFormat,Data
# Location,Score,         TimeFrame,DataFormat,Data
# Location,Race Ethnicity,TimeFrame,DataFormat,Data
