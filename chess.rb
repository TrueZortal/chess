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

  def initialize(colour, x, y)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(x, y)

    @unmoved = true
    @symbol = 'P'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
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

  def initialize(colour, x, y)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(x, y)

    @unmoved = true
    @symbol = 'R'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
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

  def initialize(colour, x, y)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(x, y)

    @unmoved = true
    @symbol = 'B'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
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
    @attacking_fields.delete_if {|coordinate| coordinate.reduce {|x| x < 0 || x > 8}}

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

  def initialize(colour, x, y)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(x, y)

    @unmoved = true
    @symbol = 'K'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
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

  def initialize(colour, x, y)
    raise ArgumentError unless valid_colour(colour.downcase) && valid_position_coordinates(x, y)

    @unmoved = true
    @symbol = 'KK'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    @target_position = calculate_requested_position(chess_position_notation)
    raise InvalidMoveError unless valid_moves.include?(@target_position)

    @unmoved = false
    @position = @target_position
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
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