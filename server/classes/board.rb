
require_relative 'cell'

class Board
  attr_reader :board

  def initialize
    @board = []
    @size = 15
    @total_bacteria = 0
    @tracked_cells = {}
  end

  def create_cells
    (0..@size).each do |x|
      @board[x] = [] unless @board[x]
      (0..@size).each do |y|
        @board[x][y] = Cell.new(get_random_type)
      end
    end
  end

  def pass_board_state
    (0..@board.length).each do |x|
      (0..@board[x].length).each do |y|
        @next_board[x][y] = Cell.new
      end
    end
  end

  # FIXME: This probably shouldn't be here
  def get_random_type(entropy = 0)
    entropy ||= 21
    dice = rand(0..100)

    return 2 if dice < entropy / 3

    return 3 if dice < entropy / 3 * 2

    return 4 if dice < entropy

    1
  end

  def next_state
    # Prepare the new board, which will take place on the current array.
    @next_board = []
    current_alive = []
    bacterias = []

    # Check each tracked cell and its state to calculate the next state for each position
    @tracked_cells.each do |coords|
      tracked_state = @tracked_cells[coords]

      if tracked_state.has_bacteria?
        # The cell has a bacteria living in it
        current_alive.push(tracked_state.pos.x + ',' + tracked_state.pos.y)
        # Check if it stays alive
        bacteria = get_cell(tracked_state.pos.x, tracked_state.pos.y).inhabitant
        if tracked_state.sorrounding[bacteria.id]
          if tracked_state.sorrounding[bacteria.id].quantity < bacteria.overpopulation && tracked_state.sorrounding[bacteria.id].quantity > bacteria.solitude
            # It doesn't die, we store it as a survivor
            bacterias[tracked_state.pos.x + ',' + tracked_state.pos.y] = bacteria
            next
          end
        end
      end

      # Empty cell, check if reproduction applies
      reproducers = []
      tracked_state.sorrounding.each do |sur|
        if tracked_state.sorrounding[sur].quantity === tracked_state.sorrounding[sur].type.fertility
          reproducers.push(tracked_state.sorrounding[sur].type)
        end
        if reproducers.length === 1
          bacterias[tracked_state.pos.x + ',' + tracked_state.pos.y] = reproducers[0]
        end
        if reproducers.length > 1
          bacterias[tracked_state.pos.x + ',' + tracked_state.pos.y] = new Bacteria()
        end
      end
    end

    update_board_state(current_alive, bacterias)
  end

  def update_board_state(current_alive, next_state_living)
    # Kill bacterias on coordinates where they aren't going to survive
    living_coords = next_state_living.keys
    current_alive.each do |coords|
      next unless living_coords.index coords
      hash[x, y] = coords.split(',')
      @board[x][y].kill
      @total_bacteria -= 1
      tracked_cells[x + ',' + y].delete
    end

    next_state_living.each do |coords|
      next unless current_alive.index coords
      hash[x, y] = coords.split(',')
      populate_cell(x, y, next_state_living[coords])
    end
  end

  def best_genetics(reproducers)
    proto = { genetics: { fertility: 10, solitude: -1, overpopulation: 10, color: 0 } }
    reproducers.each do |rep|
      proto.fertility = rep.fertility if rep.fertility < proto.fertility

      proto.overpopulation = rep.overpopulation if rep.overpopulation > proto.overpopulation

      proto.solitude = rep.solitude if rep.solitude < proto.solitude

      proto.color += ('0x' + rep.color).to_i / 2
    end

    proto.solitude = proto.fertility - 1 if proto.solitude >= proto.fertility

    proto.color = proto.color.to_s
    proto
  end

  # Gets the cell from the active instance board.
  def get_cell(x, y)
    get_cell_from_board(@board, x, y)
  end

  def get_cell_from_board(board, x, y)
    return false if !board[x] || !board[x][y]
    board[x][y]
  end

  def is_habitated?(x, y)
    cell = get_cell(x, y)
    return false unless cell

    true
  end

  def populate_cell(x, y, bacteria)
    cell = get_cell(x, y)
    if cell && cell.inhabit(bacteria)
      @total_bacteria += 1
      track_cell(x, y, bacteria)
    end
  end

  def track_cell(x, y, bacteria)
    mark_cell(x, y)
    @tracked_cells[x + ',' + y].state = 'bacteria'
    [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].each do |coord|
      sorrounded_cell(x + coord[0], y + coord[1], bacteria)
    end
  end

  def sorrounded_cell(x, y, bacteria)
    if mark_cell(x, y)
      pos = x + ',' + y
      unless tracked_cells[pos].sorrounding[bacteria.id]
        tracked_cells[pos].sorrounding[bacteria.id] = { type: bacteria, quantity: 0 }
      end
      tracked_cells[pos].sorrounding[bacteria.id].quantity += 1
    end
  end

  def mark_cell
    if x > -1 && y > -1 && x < this.size - 1 && y < this.size - 1
      pos = x + ',' + y
      unless tracked_cells[pos]
        tracked_cells[pos] = CellTracker.new(x, y, get_cell(x, y).type)
      end
      return true
    end

    false
  end

  def show
    opt = ''
    (0..@size).each do |x|
      (0..@size).each do |y|
        opt += '' + @board[y][x]
      end
      opt += '|\n'
    end
    puts opt
  end
end
