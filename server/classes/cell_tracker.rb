class CellTracker
  def initialize(x, y, cell_type = '_', state = 'empty')
    @pos = { x: x, y: y }
    @cell_type = cell_type
    @state = state
    @environment = {
      'R' => 0,
      'T' => 0,
      'F' => 0
    }
    @sorrounding = {}
  end

  def has_bacteria?
    @state === 'bacteria'
  end
end
