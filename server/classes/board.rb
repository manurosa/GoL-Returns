Cell = require_relative('cell')
module GoLServer
  class Board
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
    def get_random_type(entropy)
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

      # TODO: update board
    end

    # Gets the cell from the active instance board.
    def get_cell(x, y)
      get_cell_from_board(@board, x, y)
    end

    def get_cell_from_board(board, x, y)
      return false if !board[x] || !board[x][y]
      board[x][y]
    end
  end
end
