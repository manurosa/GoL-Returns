require_relative 'cell'

module GoLServer
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
          @board[x][y] = GoLServer::Cell.new(get_random_type)
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

        # I need t implement the tracked cells
      end
    end
  end
end
