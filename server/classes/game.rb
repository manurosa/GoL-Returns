class Game
  @@PLAYER_AREA = 16

  def initialize(owner, board)
    @owner = owner
    @board = board
    @status = 1
    @generation = 0
    @players = {}
    # @add_player(@owner) WTF
    @entropy = 21
    @locked_on_play = true
    @play_interval = nil
  end

  def add_player(player)
    @players.store(player.id, player)
    update_board_size
  end

  def update_board_size
    new_num = PLAYER_AREA + @player.size * PLAYER_AREA
    @board.size = new_num if new_num > @board.size
  end

  def start
    @board.create_cells
    count = 1
    @players.each do |player|
      populate_cells(player.bacteria_prototype, count)
      count += 1
    end
    @status = 2
  end

  def populate_cells(bact_proto, pos)
    range = (rand * PLAYER_AREA).floor + 1
    bact_proto.pattern.each do |coord|
      @board.populate_cell(pos * range + coord.x, pos * range + coord.y, Bacteria.new(bact_proto.owner, bact_proto.genetics))
    end
  end

  def next
    if @status != 2
      return

    @board.next_state
    @generation += 1
  end

  def start_automation
    # TODO: Implement me
  end

  def pause
    # TODO: Implement me
  end

  def run_generation
    if status != 2
      return

    @board.board.each do |cell|
      board.evaluate_generation(cel[x], cell[y])
      puts 'Evaluating on ' + cell[x].to_s + cell[y].to_s
    end

    @generation += 1
  end

  def report_status
    @board.show
  end
end
