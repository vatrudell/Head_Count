require 'csv'
require 'pry'
#require './lib/district_repository'

module Sanitation
  attr_accessor :cleaned_numbers

  def initialize
    @cleaned_numbers = 0
  end

  def self.clean_numbers
    @file.each do |line|
      line[:timeframe].to_i
      line[:data][0..4].to_f
    end
  end
end
