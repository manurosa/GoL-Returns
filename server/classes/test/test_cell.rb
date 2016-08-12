require 'test/unit'
require 'mocha/test_unit'
require_relative '../cell'
require_relative '../bacteria'

class CellTest < Test::Unit::TestCase
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
    bacteria = Bacteria.new('owner', 'genetics')

    puts cell.inhabit(bacteria)

    assert cell.inhabitant.is_a? Bacteria
  end
end
