class ChessPiece
  attr_accessor :position, :chess_notation_position
  attr_reader :colour, :attacking_fields, :symbol, :unmoved

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

  def initialize(colour, initial_position)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(calculate_requested_position(initial_position)[0], calculate_requested_position(initial_position)[1])

    @unmoved = true
    assign_symbol
    @colour = colour.downcase
    @chess_notation_position = initial_position
    @position = calculate_requested_position(@chess_notation_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @chess_notation_position = chess_position_notation
    @position = @target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars

    raise ArgumentError unless @@board.include?(requested_move[0].downcase)

    vertical = requested_move[1].to_i
    horizontal = @@board[requested_move[0].downcase]
    [horizontal, vertical - 1]
  end

  def valid_moves
    x = @position[0]
    y = @position[1]
    locate_attacking_fields(x, y)
    valid_moves = [@attacking_fields].flatten(1)

    valid_moves.delete_if {|position| position == @position}
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
  end

  def is_white
    @colour == 'white'
  end

  def is_black
    @colour == 'black'
  end
end