class ChessPiece
  attr_accessor :position
  attr_reader :colour, :attacking_fields, :symbol

  @@board = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7
  }

  def initialize(colour, x, y)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(x, y)

    @symbol = 'symbol'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(target_position)

    @position = target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
    vertical = requested_move[1].to_i
    horizontal = @@board[requested_move[0]]
    [horizontal, vertical - 1]
  end

  def valid_moves
    x = @position[0]
    y = @position[1]
    locate_attacking_fields(x, y)
    valid_moves = [@attacking_fields].flatten(1)

    valid_moves
  end

  def locate_attacking_fields(x, y)
    if is_white
      @attacking_fields =
    elsif is_black
      @attacking_fields =
  end

  def valid_position_coordinates(x, y)
    x < 8 && x >= 0 && y >= 0 && y < 8
  end

  def valid_colour(colour)
    colours = %w[white black]
    colours.include?(colour.downcase)

  def is_white
    @colour == 'white'
  end

  def is_black
    @colour == 'black'
  end
end