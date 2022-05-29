# frozen_string_literal: true

class InvalidMoveError < StandardError
  def initialize(msg = 'invalid move buddy')
    super
  end
end

class Pawn
  attr_accessor :position
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
    @position = calculate_requested_position(initial_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def assign_symbol
    if is_white
      @symbol = "♟"
    else
      @symbol = "♙"
    end
  end

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars

    raise ArgumentError unless @@board.include?(requested_move[0].downcase)

    vertical = requested_move[1].to_i
    horizontal = @@board[requested_move[0].downcase]
    [horizontal, vertical - 1]
  end

  def valid_moves
    set_modifier
    x = @position[0]
    y = @position[1]
    locate_attacking_fields(x, y)
    valid_moves = [@attacking_fields].flatten(1)

    if in_starting_position
      valid_positions = [[x, y + 2 * @modifier], [x, y + 1 * @modifier]]
      valid_moves.concat(valid_positions)
    else
      valid_moves << [x, y + 1 * @modifier]
    end
    valid_moves.delete_if {|position| position == @position}
  end

  def locate_attacking_fields(x, y)
    if is_white
      @attacking_fields = [[x - 1, y + 1], [x + 1, y + 1]]
    elsif is_black
      @attacking_fields = [[x - 1, y - 1], [x + 1, y - 1]]
    end
  end

  def valid_position_coordinates(x, y)
    x < 8 && x >= 0 && y >= 0 && y < 8
  end

  def valid_colour(colour)
    colours = %w[white black]
    colours.include?(colour.downcase)
  end

  def in_starting_position
    if is_white
      @position[1] == 1
    elsif is_black
      @position[1] == 6
    end
  end

  def set_modifier
    @modifier = case @colour
                when 'white'
                  1
                when 'black'
                  -1
                end
  end

  def is_white
    @modifier = 1
    @colour == 'white'
  end

  def is_black
    @modifier = -1
    @colour == 'black'
  end
end

class Rook
  attr_accessor :position
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
    @position = calculate_requested_position(initial_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def assign_symbol
    if is_white
      @symbol = "♜"
    else
      @symbol = "♖"
    end
  end

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
    @attacking_fields = []
    @@board.values.each do |field|
      @attacking_fields << [[x, field], [field, y]]
    end
    @attacking_fields.flatten!(1)
    @attacking_fields.delete_if {|field| field == [x, y]}
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

class Bishop
  attr_accessor :position
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
    @position = calculate_requested_position(initial_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def assign_symbol
    if is_white
      @symbol = "♝"
    else
      @symbol = "♗"
    end
  end

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
    @attacking_fields = []
    temp_y = y
    mod = 1
    while temp_y > 0
      temp_y -= 1
      @attacking_fields << [x - mod, temp_y]
      @attacking_fields << [x + mod, temp_y]
      mod += 1
    end
    temp_y = y
    mod = 1
    while temp_y < 8
      temp_y += 1
      @attacking_fields << [x - mod, temp_y]
      @attacking_fields << [x + mod, temp_y]
      mod += 1
    end
    @attacking_fields

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

class Knight
  attr_accessor :position
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
    @position = calculate_requested_position(initial_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def assign_symbol
    if is_white
      @symbol = "♞"
    else
      @symbol = "♘"
    end
  end

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
    valid_moves = [@attacking_fields].flatten(2)

    valid_moves.delete_if {|position| position == @position}
  end

  def locate_attacking_fields(x, y)
    mod_1 = 1
    mod_2 = 2
    @attacking_fields = []
    0.upto(1) do
      @attacking_fields << [
        [x - mod_1, y + mod_2],
        [x - mod_1, y - mod_2],
        [x + mod_1, y + mod_2],
        [x + mod_1, y - mod_2]
      ]
      mod_1 = 2
      mod_2 = 1
    end
    @attacking_fields
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

class King
  attr_accessor :position
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
    @position = calculate_requested_position(initial_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def assign_symbol
    if is_white
      @symbol = "♚"
    else
      @symbol = "♔"
    end
  end

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
    if @unmoved == true && is_white
      valid_moves << [[7,0],[0,0]]
    elsif @unmoved == true && is_black
      valid_moves << [[7,7],[0,7]]
    end

    valid_moves.delete_if {|position| position == @position}

  end

  def locate_attacking_fields(x, y)
      @attacking_fields = []
      [1, 0, -1].each do |num_x|
        [1, 0, -1].each do |num_y|
          @attacking_fields << [x + num_x, y + num_y]
        end
      end
      @attacking_fields
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

class Queen
  attr_accessor :position
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
    @position = calculate_requested_position(initial_position)
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def assign_symbol
    if is_white
      @symbol = "♛"
    else
      @symbol = "♕"
    end
  end

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
    @attacking_fields = []
    @@board.values.each do |field|
      @attacking_fields << [[x, field], [field, y]]
    end
    @attacking_fields.flatten!(1)
    temp_y = y
    mod = 1
    while temp_y > 0
      temp_y -= 1
      @attacking_fields << [x - mod, temp_y]
      @attacking_fields << [x + mod, temp_y]
      mod += 1
    end
    temp_y = y
    mod = 1
    while temp_y < 8
      temp_y += 1
      @attacking_fields << [x - mod, temp_y]
      @attacking_fields << [x + mod, temp_y]
      mod += 1
    end
    @attacking_fields
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

class Board
  attr_accessor :board
  def initialize
    generate_a_hash_of_fields
    initial_setup
    print_board
  end

  def initial_setup
    ('a'..'h').each do |letter|
      @board["#{letter}2"] = Pawn.new('white', "#{letter}2")
      @board["#{letter}7"] = Pawn.new('black', "#{letter}7")
    end
  end

  def print_board
    view = <<_
  A B C D E F G H
1 #{@board["a1"]} #{@board["b1"]} #{@board["c1"]} #{@board["d1"]} #{@board["e1"]} #{@board["f1"]} #{@board["g1"]} #{@board["h1"]} 1
2 #{@board["a2"]} #{@board["b2"]} #{@board["c2"]} #{@board["d2"]} #{@board["e2"]} #{@board["f2"]} #{@board["g2"]} #{@board["h2"]} 2
3 #{@board["a3"]} #{@board["b3"]} #{@board["c3"]} #{@board["d3"]} #{@board["e3"]} #{@board["f3"]} #{@board["g3"]} #{@board["h3"]} 3
4 #{@board["a4"]} #{@board["b4"]} #{@board["c4"]} #{@board["d4"]} #{@board["e4"]} #{@board["f4"]} #{@board["g4"]} #{@board["h4"]} 4
5 #{@board["a5"]} #{@board["b5"]} #{@board["c5"]} #{@board["d5"]} #{@board["e5"]} #{@board["f5"]} #{@board["g5"]} #{@board["h5"]} 5
6 #{@board["a6"]} #{@board["b6"]} #{@board["c6"]} #{@board["d6"]} #{@board["e6"]} #{@board["f6"]} #{@board["g6"]} #{@board["h6"]} 6
7 #{@board["a7"]} #{@board["b7"]} #{@board["c7"]} #{@board["d7"]} #{@board["e7"]} #{@board["f7"]} #{@board["g7"]} #{@board["h7"]} 7
8 #{@board["a8"]} #{@board["b8"]} #{@board["c8"]} #{@board["d8"]} #{@board["e8"]} #{@board["f8"]} #{@board["g8"]} #{@board["h8"]} 8
  A B C D E F G H
_
puts view
  end

  def generate_a_hash_of_fields
    @board = Hash.new
    ('a'..'h').each do |letter|
      (1..8).each do |index|
        @board["#{letter}#{index}"] = "*"
      end
    end
    @board
  end
end

chessboard = Board.new
chessboard.board['a1']