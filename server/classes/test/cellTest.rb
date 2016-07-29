require '../cell'
require 'test/unit'
require 'mocha/test_unit'

class CellTest < Test::Unit::TestCase
  def test_cell_instance_without_type
    cell = GoLServer::Cell.new(1)

    assert 1, cell.type
  end
end
