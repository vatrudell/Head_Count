require './lib/statewide_test_repository'
require 'minitest/autorun'
require 'minitest/pride'


class StateWideTestRepositoryTest < Minitest::Test
  def test_derp
    assert_equal "derp", "derp"
  end
end
