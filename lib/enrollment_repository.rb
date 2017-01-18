require_relative '../lib/enrollment'
require_relative '../lib/sanitation'
require 'pry'

class EnrollmentRepository
  include Sanitation
  attr_accessor :enrollments,
                :clean_enrollments_data
  def initialize
    @enrollments = {}
  end

  def load_data(input)
    clean_up_enrollment_data(input)
  end
#@name = name, also do year and data
  def populate_kindergarten_data
    if enrollments.keys.include?(@name)
     enrollments[@name].kindergarten_participation[@year] = @data
    else
     enrollments[@name] = Enrollment.new({
       name: @name,
       kindergarten_participation: {@year => @data}})
    end
  end

  def populate_high_school_data
    if enrollments.keys.include?(@name)
      enrollments[@name].high_school_graduation[@year] = @data
    else
      enrollments[@name] = Enrollment.new({ name: @name,
        high_school_graduation: {@year => @data}})
     end
  end

  def find_by_name(district_name)
    enrollments[district_name]
  end
end
