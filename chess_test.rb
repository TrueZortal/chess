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
    pawn = Pawn.new('white', 1, 2)
    pawn.move('b4')
    assert_equal [1,4], pawn.position
  end

  def test_white_pawn_can_move_1_field_if_in_starting_position
    skip
    pawn = Pawn.new('white', 1, 2)
    pawn.move('b3')
    assert_equal [1,3], pawn.position
  end

  def test_white_pawn_moves_1_field_if_in_any_other_position
    skip
    pawn = Pawn.new('white', 1, 4)
    pawn.move('b6')
    assert_equal [1,5], pawn.position
  end

  def test_black_pawn_moves_2_fields_if_in_starting_position
    skip
    pawn = Pawn.new('black', 1, 7)
    pawn.move('b5')
    assert_equal [1,5], pawn.position
  end

  def test_black_pawn_moves_1_field_if_in_any_other_position
    skip
    pawn = Pawn.new('black', 1, 5)
    pawn.move('b5')
    assert_equal [1,4], pawn.position
  end

  def test_rook_starting_position_is_valid
    skip
    assert_raises(ArgumentError) do
      Rook.new('white', 2, -2)
    end
  end

  def test_rook_can_only_be_black_or_white
    skip
    assert_raises(ArgumentError) do
      Rook.new('potato', 2, -2)
    end
  end

  def test_rook_can_move_diagonal
    skip
    rook = Rook.new('black', 0, 0)
    rook.move('a8')
    asser_equal [0,7], rook.position
  end

  def test_rook_can_move_horizontal
    skip
    rook = Rook.new('black', 0, 0)
    rook.move('h1')
    asser_equal [7,0], rook.position
  end

  def rook_cant_move_across
    skip
    assert_raises(InvalidMoveError) do
      rook = Rook.new('black', 2, 2)
      rook.move('d4')
    end
  end

end