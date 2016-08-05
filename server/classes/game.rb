
  class Game
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
      # update_board_size
    end

    def update_board_size
      # new_num =
    end
  end
