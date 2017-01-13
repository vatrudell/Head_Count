require './test/test_helper'
require_relative '../lib/sanitation'

 class SanitationTest < Minitest::Test
   def test_sanitation_opens_files
     Sanitation.make_values_useable([
       "./data/Kindergartners in full-day program.csv",
       "./data/High school graduation rates.csv"])
     assert_equal "derp", expected
   end
 end
