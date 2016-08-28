require 'test/unit'
require 'mocha/test_unit'
require_relative '../cell'
require_relative '../bacteria'
require_relative '../user'

class CellTest < Test::Unit::TestCase
  def set_bacteria_params
    @owner = User.new('socket')
    @genetics = {
      fertility: 3,
      solitude: 1,
      overpopulation: 4,
      colour: '#000'
    }
  end

  def test_cell_instance_without_type
    cell = Cell.new(1)

    assert_equal '1', cell.type.to_s
  end

  def test_cell_make_type
    cell = Cell.new(1)

    cell.make_type(2)

    assert_equal '2', cell.type.to_s
  end

  def test_cell_make_wrong_type
    cell = Cell.new(1)

    cell.make_type(3)

    assert_not_equal '2', cell.type.to_s
  end

  def test_inhabit_cell_with_bacteria
    cell = Cell.new(1)
    set_bacteria_params
    bacteria = Bacteria.new(@owner, @genetics)

    cell.inhabit(bacteria)

    assert cell.inhabitant.is_a? Bacteria
  end

  def test_cell_is_inhabitated
    cell = Cell.new(1)
    set_bacteria_params
    bacteria = Bacteria.new(@owner, @genetics)

    cell.inhabit(bacteria)

    assert cell.is_inhabitated?
  end

  def test_cell_not_habitated_conversion_to_string
    cell = Cell.new(1)

    assert_equal '|_', cell.to_string
  end

  def test_cell_rock_conversion_to_string
    cell = Cell.new(2)

    assert_equal '|R', cell.to_string
  end

  def test_cell_fertile_conversion_to_string
    cell = Cell.new(1)

    cell.make_type(4)

    assert_equal '|F', cell.to_string
  end

  def test_habitated_cell_conversion_to_string
    cell = Cell.new(1)
    set_bacteria_params
    bacteria = Bacteria.new(@owner, @genetics)

    cell.inhabit(bacteria)

    assert_equal bacteria.to_s, cell.to_string
  end
end
