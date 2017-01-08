require 'csv'
require 'pry'
#require './lib/district_repository'

module Sanitation
  attr_accessor :cleaned_numbers

  def initialize
    # @cleaned_numbers = 0
  end

  def self.clean_numbers
    @file
    binding.pry

    @file.each do |line|
      line[:timeframe].to_i
      line[:data][0..4].to_f
    end
  end
end
#
# dr = DistrictRepository.new
# dr.load_data({
#                :enrollment => {
#                  :kindergarten => "./data/Kindergartners in full-day program.csv"
#                }
#              })
# puts dr.find_by_name("ACADEMY 20")
#
# new = Sanitation.new
# new.clean_numbers
