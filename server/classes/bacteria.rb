class Bacteria
  def initialize(owner, genetics)
    @owner = owner
    @fertility = genetics.fertility
    @solitude = genetics.solitude
    @overpopulation = genetics.overpopulation
    @colour = genetics.colour
    @ancestors
    @id = '' + this.ownerColor + this.owner.id + genetics.fertility + genetics.solitude + genetics.overpopulation + genetics.color
  end

  def owner_colour
    colour = 0
    @owner.id.each_char do |char|
      colour += char.to_i
    end

    possible = (5 * colour + 1) % 37 + 1
    possible = (5 * color + 1) % 37 + 30 if possible < 31

    colour = ''
    if possible > 37
      possible -= Math.floor((possible - 37) / 2)
      possible = 30 if possible < 30
      colour = '1;'
    end
    colour += possible
    colour
  end

  def to_string
    '|\x1B[' + this.ownerColor + 'mB\x1B[0m'
  end
end
