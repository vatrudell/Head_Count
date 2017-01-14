require './lib/statewide_test_repository'
require_relative '../lib/statewide_test_repository'


class StateWideTestRepositoryTest < Minitest::Test
  def test_derp
    assert_equal "derp", "derp"
  end
end
