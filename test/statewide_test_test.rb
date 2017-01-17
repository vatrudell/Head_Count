require './test/test_helper'
require_relative '../lib/statewide_test_repository'


class StateWideTestTest < Minitest::Test
  attr_reader :stwr,
              :statewide_object,
              :statewide_test
  def test_shit

    #========================= may or may not need this, get rid of! ========
    @statewide_test = StateWideTest.new({
      :name => "ACADEMY 20",
      :grade_three_proficient =>
              {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
               2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
               2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
               2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
               2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
               2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
               2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}},
      :grade_eight_proficient =>
               {2008=>{:math=>0.64, :reading=>0.843, :writing=>0.734},
                2009=>{:math=>0.656, :reading=>0.825, :writing=>0.701},
                2010=>{:math=>0.672, :reading=>0.863, :writing=>0.754},
                2011=>{:reading=>0.832, :math=>0.653, :writing=>0.745},
                2012=>{:math=>0.681, :writing=>0.738, :reading=>0.833},
                2013=>{:math=>0.661, :reading=>0.852, :writing=>0.75},
                2014=>{:math=>0.684, :reading=>0.827, :writing=>0.747}},
      :average_proficiency =>
      {:all_students=>
                {2011=>{:math=>0.68, :reading=>0.83, :writing=>0.719},
                 2012=>{:math=>0.689, :reading=>0.845, :writing=>0.705},
                 2013=>{:math=>0.696, :reading=>0.845, :writing=>0.72},
                 2014=>{:math=>0.699, :reading=>0.841, :writing=>0.715}},
               :asian=>
                {2011=>{:math=>0.816, :reading=>0.897, :writing=>0.826},
                 2012=>{:math=>0.818, :reading=>0.893, :writing=>0.808},
                 2013=>{:math=>0.805, :reading=>0.901, :writing=>0.81},
                 2014=>{:math=>0.8, :reading=>0.855, :writing=>0.789}},
               :black=>
                {2011=>{:math=>0.424, :reading=>0.662, :writing=>0.515},
                 2012=>{:math=>0.424, :reading=>0.694, :writing=>0.504},
                 2013=>{:math=>0.44, :reading=>0.669, :writing=>0.481},
                 2014=>{:math=>0.42, :reading=>0.703, :writing=>0.519}},
               :pacific_islander=>
                {2011=>{:math=>0.568, :reading=>0.745, :writing=>0.725},
                 2012=>{:math=>0.571, :reading=>0.833, :writing=>0.683},
                 2013=>{:math=>0.683, :reading=>0.866, :writing=>0.716},
                 2014=>{:math=>0.681, :reading=>0.931, :writing=>0.727}},
               :hispanic=>
                {2011=>{:math=>0.568, :reading=>0.748, :writing=>0.606},
                 2012=>{:math=>0.572, :reading=>0.771, :writing=>0.597},
                 2013=>{:math=>0.588, :reading=>0.772, :writing=>0.623},
                 2014=>{:math=>0.604, :reading=>0.007, :writing=>0.624}},
               :native_american=>
                {2011=>{:math=>0.614, :reading=>0.816, :writing=>0.6},
                 2012=>{:math=>0.571, :reading=>0.785, :writing=>0.589},
                 2013=>{:math=>0.593, :reading=>0.813, :writing=>0.61},
                 2014=>{:math=>0.543, :reading=>0.007, :writing=>0.62}},
               :two_or_more=>
                {2011=>{:math=>0.677, :reading=>0.841, :writing=>0.727},
                 2012=>{:math=>0.689, :reading=>0.845, :writing=>0.718},
                 2013=>{:math=>0.696, :reading=>0.855, :writing=>0.747},
                 2014=>{:math=>0.693, :reading=>0.008, :writing=>0.731}},
               :white=>
                {2011=>{:math=>0.706, :reading=>0.851, :writing=>0.74},
                 2012=>{:math=>0.713, :reading=>0.861, :writing=>0.726},
                 2013=>{:math=>0.72, :reading=>0.86, :writing=>0.74},
                 2014=>{:math=>0.723, :reading=>0.008, :writing=>0.734}}}})
#========================= may or may not need this, get rid of! ==============
    expected_one = {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
                   2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
                   2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
                   2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
                   2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
                   2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
                   2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}}
    assert_equal expected_one, statewide_test.grade_three_proficient

    expected_two = {2008=>{:math=>0.64, :reading=>0.843, :writing=>0.734},
                   2009=>{:math=>0.656, :reading=>0.825, :writing=>0.701},
                   2010=>{:math=>0.672, :reading=>0.863, :writing=>0.754},
                   2011=>{:reading=>0.832, :math=>0.653, :writing=>0.745},
                   2012=>{:math=>0.681, :writing=>0.738, :reading=>0.833},
                   2013=>{:math=>0.661, :reading=>0.852, :writing=>0.75},
                   2014=>{:math=>0.684, :reading=>0.827, :writing=>0.747}}
                  #require 'pry'; binding.pry
    assert_equal expected_two, statewide_test.grade_eight_proficient

    expected_three = {:all_students=>
              {2011=>{:math=>0.68, :reading=>0.83, :writing=>0.719},
               2012=>{:math=>0.689, :reading=>0.845, :writing=>0.705},
               2013=>{:math=>0.696, :reading=>0.845, :writing=>0.72},
               2014=>{:math=>0.699, :reading=>0.841, :writing=>0.715}},
             :asian=>
              {2011=>{:math=>0.816, :reading=>0.897, :writing=>0.826},
               2012=>{:math=>0.818, :reading=>0.893, :writing=>0.808},
               2013=>{:math=>0.805, :reading=>0.901, :writing=>0.81},
               2014=>{:math=>0.8, :reading=>0.855, :writing=>0.789}},
             :black=>
              {2011=>{:math=>0.424, :reading=>0.662, :writing=>0.515},
               2012=>{:math=>0.424, :reading=>0.694, :writing=>0.504},
               2013=>{:math=>0.44, :reading=>0.669, :writing=>0.481},
               2014=>{:math=>0.42, :reading=>0.703, :writing=>0.519}},
             :pacific_islander=>
              {2011=>{:math=>0.568, :reading=>0.745, :writing=>0.725},
               2012=>{:math=>0.571, :reading=>0.833, :writing=>0.683},
               2013=>{:math=>0.683, :reading=>0.866, :writing=>0.716},
               2014=>{:math=>0.681, :reading=>0.931, :writing=>0.727}},
             :hispanic=>
              {2011=>{:math=>0.568, :reading=>0.748, :writing=>0.606},
               2012=>{:math=>0.572, :reading=>0.771, :writing=>0.597},
               2013=>{:math=>0.588, :reading=>0.772, :writing=>0.623},
               2014=>{:math=>0.604, :reading=>0.007, :writing=>0.624}},
             :native_american=>
              {2011=>{:math=>0.614, :reading=>0.816, :writing=>0.6},
               2012=>{:math=>0.571, :reading=>0.785, :writing=>0.589},
               2013=>{:math=>0.593, :reading=>0.813, :writing=>0.61},
               2014=>{:math=>0.543, :reading=>0.007, :writing=>0.62}},
             :two_or_more=>
              {2011=>{:math=>0.677, :reading=>0.841, :writing=>0.727},
               2012=>{:math=>0.689, :reading=>0.845, :writing=>0.718},
               2013=>{:math=>0.696, :reading=>0.855, :writing=>0.747},
               2014=>{:math=>0.693, :reading=>0.008, :writing=>0.731}},
             :white=>
              {2011=>{:math=>0.706, :reading=>0.851, :writing=>0.74},
               2012=>{:math=>0.713, :reading=>0.861, :writing=>0.726},
               2013=>{:math=>0.72, :reading=>0.86, :writing=>0.74},
               2014=>{:math=>0.723, :reading=>0.008, :writing=>0.734}}}
    assert_equal expected_three, statewide_test.average_proficiency


    actual_one = statewide_test.proficient_by_grade(3)
    expected_four = {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
                   2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
                   2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
                   2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
                   2012=>{:reading=>0.87, :math=>0.83, :writing=>0.655},
                   2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
                   2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}}
    assert_equal expected_four, actual_one
    #need a test for when grad isn't there
    # " when input is incorrect

    actual_two = statewide_test.proficient_by_race_or_ethnicity(:white)
    expected_five = {2011=>{:math=>0.706, :reading=>0.851, :writing=>0.74},
                     2012=>{:math=>0.713, :reading=>0.861, :writing=>0.726},
                     2013=>{:math=>0.72,  :reading=>0.86,  :writing=>0.74},
                     2014=>{:math=>0.723, :reading=>0.008, :writing=>0.734}}
    assert_equal expected_five, actual_two
    #" for when race isn't there
    # " when input is incorrect

    actual_three = statewide_test.proficient_for_subject_by_race_in_year(:math, :asian, 2011)
    assert_equal 0.816, actual_three

    #need a test for when year isn't there
    #" for when math isn't there
    #" for when race isn't there
    #" when input entered is incorrect"

    actual_four = statewide_test.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    assert_equal 0.857, actual_four

    #need a test for when year isn't there
    #" for when math isn't there
    #" for when grade isn't there
    #" when input entered is incorrect"

  end
  def test_statewide_name
  end

  def test_statewide_class
  end

  def test_statewide_grade_three_proficient
  end

  def test_statewide_eight_three_proficient
  end

  def test_statewide_average_proficiency
  end

  def proficient_by_grade
  end

  def test_proficient_by_race_or_ethnicity
  end

  def test_proficient_for_subject_by_race_in_year
  end

  def test_roficient_for_subject_by_grade_in_year
  end
end
