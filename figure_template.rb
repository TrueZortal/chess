class ChessPiece
  @@board = [
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7,
  ]
  attr_accessor :position
  attr_reader :colour, :attacking_fields

  def initialize(colour,x,y)
    raise ArgumentError if valid_position_coordinates(x, y) || valid_colour(colour)

    @colour = colour.downcase
    @position = [x, y]
    locate_attacking_fields
  end

  def move
  end

  private

  def locate_attacking_fields
    if is_white
      @attacking_fields =
    elsif is_black
      @attacking_fields =
    end
  end

  def valid_position_coordinates(x, y)
    x > 8 || x < 1 || y < 1 || y > 8
  end

  def valid_colour(colour)
    colours = ['white', 'black']
    !colours.include?(colour.downcase)
  end

  def is_white
    @colour == 'white'
  end

  def is_black
    @colour == 'black'
  end
end