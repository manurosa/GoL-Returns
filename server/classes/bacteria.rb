class Bacteria
  def initialize(owner, genetics)
    @owner = owner
    @fertility = genetics[:fertility]
    @solitude = genetics[:solitude]
    @overpopulation = genetics[:overpopulation]
    @colour = genetics[:colour]
    @ancestors
    @id = '' + owner.id.to_s + genetics[:fertility].to_s + genetics[:solitude].to_s + genetics[:overpopulation].to_s + genetics[:colour].to_s
  end

  def owner_colour
    colour = 0
    @owner.id.each_char do |char|
      colour += char.to_i
    end

    possible = (5 * colour + 1) % 37 + 1
    possible = (5 * colour + 1) % 37 + 30 if possible < 31

    colour = ''
    if possible > 37
      possible -= ((possible - 37) / 2).floor
      possible = 30 if possible < 30
      colour = '1;'
    end
    colour += possible.to_s
    colour
  end

  def to_string
    '|\x1B[' + owner_colour + 'mB\x1B[0m'
  end
end
