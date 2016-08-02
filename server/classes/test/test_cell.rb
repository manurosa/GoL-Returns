require 'test/unit'
require 'mocha/test_unit'
require_relative '../cell'

class CellTest < Test::Unit::TestCase
  def test_cell_instance_without_type
    cell = GoLServer::Cell.new(1)
    assert_equal '1', cell.type.to_s
  end

  def test_cell_make_type
    cell = GoLServer::Cell.new(1)
    cell.make_type(2)
    assert_equal '2', cell.type.to_s
  end

  def test_cell_make_wrong_type
    cell = GoLServer::Cell.new(1)
    cell.make_type(3)
    assert_not_equal '2', cell.type.to_s
  end
end
