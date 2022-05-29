# frozen_string_literal: true

class InvalidMoveError < StandardError
  def initialize(msg = 'invalid move buddy')
    super
  end
end

class Pawn
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

  class EmptyField
    attr_accessor :symbol

    def initialize
      @symbol = "*"
    end
  end

  attr_accessor :board, :show

  def initialize
    generate_a_hash_of_fields
    initial_setup
  end

  def move_piece(starting_field, target_field)
    if @board[target_field].symbol == "*"
      @board[starting_field].move(target_field)
        if @board[starting_field].chess_notation_position == target_field
          @board[target_field] = @board[starting_field]
          @board[starting_field] = EmptyField.new
        else
          p "invalid move"
        end
      end
  end

  def show
    print_board
  end

  private

  def initial_setup
    ('a'..'h').each do |letter|
      @board["#{letter}2"] = Pawn.new('white', "#{letter}2")
      @board["#{letter}7"] = Pawn.new('black', "#{letter}7")
    end
    colour = "white"
    [1, 8].each do |outer_row|
      @board["a#{outer_row}"] = Rook.new(colour, "a#{outer_row}")
      @board["h#{outer_row}"] = Rook.new(colour, "h#{outer_row}")
      @board["b#{outer_row}"] = Knight.new(colour, "b#{outer_row}")
      @board["g#{outer_row}"] = Knight.new(colour, "g#{outer_row}")
      @board["c#{outer_row}"] = Bishop.new(colour, "c#{outer_row}")
      @board["f#{outer_row}"] = Bishop.new(colour, "f#{outer_row}")
     colour = "black"
    end
      @board["e1"] = King.new("white", "e1")
      @board["d8"] = King.new("black", "d8")
      @board["d1"] = Queen.new("white", "d1")
      @board["e8"] = Queen.new("black", "e8")
  end

  def print_board
    view = <<_
  A B C D E F G H
1 #{@board["a1"].symbol} #{@board["b1"].symbol} #{@board["c1"].symbol} #{@board["d1"].symbol} #{@board["e1"].symbol} #{@board["f1"].symbol} #{@board["g1"].symbol} #{@board["h1"].symbol} 1
2 #{@board["a2"].symbol} #{@board["b2"].symbol} #{@board["c2"].symbol} #{@board["d2"].symbol} #{@board["e2"].symbol} #{@board["f2"].symbol} #{@board["g2"].symbol} #{@board["h2"].symbol} 2
3 #{@board["a3"].symbol} #{@board["b3"].symbol} #{@board["c3"].symbol} #{@board["d3"].symbol} #{@board["e3"].symbol} #{@board["f3"].symbol} #{@board["g3"].symbol} #{@board["h3"].symbol} 3
4 #{@board["a4"].symbol} #{@board["b4"].symbol} #{@board["c4"].symbol} #{@board["d4"].symbol} #{@board["e4"].symbol} #{@board["f4"].symbol} #{@board["g4"].symbol} #{@board["h4"].symbol} 4
5 #{@board["a5"].symbol} #{@board["b5"].symbol} #{@board["c5"].symbol} #{@board["d5"].symbol} #{@board["e5"].symbol} #{@board["f5"].symbol} #{@board["g5"].symbol} #{@board["h5"].symbol} 5
6 #{@board["a6"].symbol} #{@board["b6"].symbol} #{@board["c6"].symbol} #{@board["d6"].symbol} #{@board["e6"].symbol} #{@board["f6"].symbol} #{@board["g6"].symbol} #{@board["h6"].symbol} 6
7 #{@board["a7"].symbol} #{@board["b7"].symbol} #{@board["c7"].symbol} #{@board["d7"].symbol} #{@board["e7"].symbol} #{@board["f7"].symbol} #{@board["g7"].symbol} #{@board["h7"].symbol} 7
8 #{@board["a8"].symbol} #{@board["b8"].symbol} #{@board["c8"].symbol} #{@board["d8"].symbol} #{@board["e8"].symbol} #{@board["f8"].symbol} #{@board["g8"].symbol} #{@board["h8"].symbol} 8
  A B C D E F G H
_
view
  end

  def generate_a_hash_of_fields
    @board = Hash.new
    ('a'..'h').each do |letter|
      (1..8).each do |index|
        @board["#{letter}#{index}"] = EmptyField.new
      end
    end
    @board
  end
end

chessboard = Board.new
chessboard.move_piece("b2", "b3")
p chessboard.board["b3"]
p chessboard.board["b2"]
chessboard.move_piece("f7", "f5")
puts chessboard.show
