module GoLServer
  class Cell
    attr_reader :type

    def initialize(type)
      @type = type || 1
      @inhabitant = false
      @neighbours = {
        topleft: nil,
        above: nil,
        topright: nil,
        bottomleft: nil,
        below: nil,
        bottomright: nil,
        left: nil,
        right: nil
      }
    end

    def make_type(type)
      @type = type
    end

    def inhabit(obj)
      change_bacteria_num = !@inhabitant
      @inhabitant = obj
      change_bacteria_num
    end

    def kill
      if is_inhabitated?
        @inhabitant = false
        return true
      end

      false
    end

    def is_inhabitated?
      !!@inhabitant
    end

    def to_string
      return '|' + %w(_ _ R T F)[@type] unless is_inhabitated?

      @inhabitant.to_s
    end
  end
end
