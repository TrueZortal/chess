

class Pawn

  # class MyError < StandardError
  #   p "invalid move buddy"
  # end

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

  def initialize(colour,x,y)
    raise ArgumentError if valid_position_coordinates(x, y) || valid_colour(colour)

    @symbol = 'P'
    @colour = colour.downcase
    @position = [x, y]
  end

  def move(chess_position_notation)
    target_position = calculate_requested_position(chess_position_notation)
    valid_moves(target_position)
    # raise InvalidMoveError if !valid_moves(target_position)

    # if in_starting_position
    #     @position[1] += 2 * @modifier
    # else
    #     @position[1] += 1 * @modifier
    # end
  end

  private

  def calculate_requested_position(chess_notation)
    requested_move = chess_notation.chars
    vertical = requested_move[1].to_i
    horizontal = @@board[requested_move[0]]
    [horizontal, vertical]
  end

  def valid_moves(from_position)
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
    p valid_moves
  end

  def locate_attacking_fields(x, y)
    if is_white
      @attacking_fields = [[x - 1, y + 1], [x + 1, y + 1]]
    elsif is_black
      @attacking_fields = [[x - 1, y - 1], [x + 1, y - 1]]
    end
  end

  def valid_position_coordinates(x, y)
    x > 8 || x < 1 || y < 1 || y > 8
  end

  def valid_colour(colour)
    colours = ['white', 'black']
    !colours.include?(colour.downcase)
  end

  def in_starting_position
    if is_white
      @position[1] == 2
    elsif is_black
      @position[1] == 7
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

pawn = Pawn.new('black', 1, 4)
    pawn.move('b5')
    # p pawn.position

# class Rook
#   attr_accessor :position
#   attr_reader :colour, :attacking_fields

#   def initialize(colour,x,y)
#     raise ArgumentError if valid_position_coordinates(x, y) || valid_colour(colour)

#     @colour = colour.downcase
#     @position = [x, y]
#     locate_attacking_fields
#   end

#   def move
#   end

#   private

#   def locate_attacking_fields
#     if is_white
#       @attacking_fields =
#     elsif is_black
#       @attacking_fields =
#     end
#   end

#   def valid_position_coordinates(x, y)
#     x > 8 || x < 1 || y < 1 || y > 8
#   end

#   def valid_colour(colour)
#     colours = ['white', 'black']
#     !colours.include?(colour.downcase)
#   end

#   def is_white
#     @colour == 'white'
#   end

#   def is_black
#     @colour == 'black'
#   end
# end