require 'test/unit'
require 'mocha/test_unit'
require_relative '../bacteria'

class BacteriaTest < Test::Unit::TestCase
  def set_bacteria_params
    @owner = User.new('socket')
    @genetics = {
      fertility: 3,
      solitude: 1,
      overpopulation: 4,
      colour: '#000'
    }
  end

  def test_bacteria_instance
    set_bacteria_params

    bacteria = Bacteria.new(@owner, @genetics)

    assert bacteria.is_a?(Bacteria)
  end

  def test_owner_colour_is_set
    set_bacteria_params
    bacteria = Bacteria.new(@owner, @genetics)

    colour = bacteria.owner_colour

    assert colour
  end

  def test_bacteria_to_string
    set_bacteria_params
    bacteria = Bacteria.new(@owner, @genetics)
    expected = '|\x1B[1;39mB\x1B[0m'

    bacteria_string = bacteria.to_string

    assert_equal expected, bacteria_string
  end
end
