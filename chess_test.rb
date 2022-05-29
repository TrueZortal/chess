require 'minitest/autorun'
require_relative 'chess'
class ChessTest < Minitest::Test

  def test_pawns_starting_position_is_valid
    assert_raises(ArgumentError) do
      Pawn.new('white', 2, -2)
    end
  end

  def test_pawns_can_only_be_white_or_black
    # skip
    assert_raises(ArgumentError) do
      Pawn.new('green', 1 , 2)
    end
  end

  def test_white_pawn_can_move_2_fields_if_in_starting_position
    # skip
    pawn = Pawn.new('white', 1, 1)
    pawn.move('b4')
    assert_equal [1,3], pawn.position
  end

  def test_white_pawn_can_move_1_field_if_in_starting_position
    # skip
    pawn = Pawn.new('white', 1, 1)
    pawn.move('b3')
    assert_equal [1,2], pawn.position
  end

  def test_white_pawn_moves_1_field_if_in_any_other_position
    # skip
    pawn = Pawn.new('white', 1, 4)
    pawn.move('b6')
    assert_equal [1,5], pawn.position
  end

  def test_black_pawn_moves_2_fields_if_in_starting_position
    # skip
    pawn = Pawn.new('black', 1, 6)
    pawn.move('b5')
    assert_equal [1,4], pawn.position
  end

  def test_black_pawn_moves_1_field_if_in_any_other_position
    # skip
    pawn = Pawn.new('black', 0, 5)
    pawn.move('a5')
    assert_equal [0,4], pawn.position
  end

  def test_pawn_cant_make_invalid_moves
    # skip
    assert_raises(InvalidMoveError) do
    pawn = Pawn.new('white', 1, 5)
    pawn.move('e7')
    end
  end

  def test_rook_starting_position_is_valid
    # skip
    assert_raises(ArgumentError) do
      Rook.new('white', 2, -2)
    end
  end

  def test_rook_can_only_be_black_or_white
    # skip
    assert_raises(ArgumentError) do
      Rook.new('potato', 2, -2)
    end
  end

  def test_rook_can_move_diagonal
    # skip
    rook = Rook.new('black', 0, 0)
    rook.move('A8')
    assert_equal [0,7], rook.position
  end

  def test_rook_can_move_horizontal
    # skip
    rook = Rook.new('black', 0, 0)
    rook.move('h1')
    assert_equal [7,0], rook.position
  end

  def rook_cant_move_across
    # skip
    assert_raises(InvalidMoveError) do
      rook = Rook.new('black', 2, 2)
      rook.move('d4')
    end
  end

  def test_bishop_starting_position_is_valid
    # skip
    assert_raises(ArgumentError) do
      Bishop.new('white', 2, -2)
    end
  end

  def test_bishop_can_move_diagonal
    # skip
    bishop = Bishop.new('black', 2, 2)
    bishop.move('d4')
    bishop.move('g7')
    bishop.move('d4')
    assert_equal [3,3], bishop.position
  end

  def test_bishop_cant_move_straight
    # skip
    assert_raises(InvalidMoveError) do
      bishop = Bishop.new('black', 2, 2)
      bishop.move('c4')
    end
  end

  def test_knight_can_move_the_knightly_way
    # skip
    knight = Knight.new('white', 3, 4)
    knight.move('b6')
    knight.move('d5')
    knight.move('b4')
    knight.move('d5')
    knight.move('b4')
    assert_equal [1, 3], knight.position
  end

  def test_knigth_cant_move_like_a_peasant
    # skip
    assert_raises(InvalidMoveError) do
      knight = Knight.new('white', 2, 0)
      knight.move('c2')
    end
  end

  def test_king_can_move_the_kingly_way
    skip
    king = King.new('white', 2, 0)
    king.move('d1')
    king.move('e1')
    king.move('e2')
    king.move('d3')
    asser_equal [3, 2], king.position
  end

  def test_king_cant_move_like_someone_on_a_horse_or_something
    skip
    assert_raises(InvalidMoveError) do
      king = King.new('white', 2, 0)
      king.move('c4')
    end
  end

  def test_queen_doesnt_walk_she_struts
    skip
    queen = Queen.new('white', 2, 0)
    queen.move('d1')
    queen.move('e5')
    queen.move('g7')
    queen.move('d7')
    queen.move('d3')
    asser_equal [3, 2], queen.position
  end

  def test_queen_cant_go_where_she_cant_go
    skip
    assert_raises(InvalidMoveError) do
      queen = Queen.new('white', 2, 0)
      queen.move('c4')
    end
  end
end