require 'minitest/autorun'
require_relative 'chess'

class BoardTest < Minitest::Test
  def test_a_piece_that_moved_is_still_the_same_piece
    # skip
    chessboard = Board.new
    # p chessboard.board["b2"]
    pawn = chessboard.board["b2"]
    chessboard.move_piece("b2","b3")
    assert_equal pawn, chessboard.board["b3"]
  end

  def test_there_is_no_afterimage_after_the_piece_moves
    # skip
    chessboard = Board.new
    chessboard.move_piece("b2","b3")
    assert_equal "*", chessboard.board["b2"].symbol
  end

  def test_a_piece_of_same_colour_cannot_capture_its_brethren
    # skip
    chessboard = Board.new
    assert_raises(InvalidMoveError) do
      chessboard.move_piece("b1","d2")
    end
  end

  def test_knight_can_hop_over_other_pieces
    skip
    chessboard = Board.new
    chessboard.move_piece("b2","c3")
    assert_equal "♞", chessboard.board["c3"].symbol
  end

  def test_no_nonknight_piece_can_hop_over_others_aka_collission_detection
    skip
    chessboard = Board.new
    assert_raises(InvalidMoveError) do
      chessboard.move_piece("a1","a5")
    end
  end

  def test_an_enemy_piece_can_be_captured
    skip
    chessboard = Board.new
    assassination_target = chessboard.board["a7"]
    chessboard.move_piece("b1", "c3")
    chessboard.move_piece("c3", "b5")
    chessboard.move_piece("b5", "a7")
    refute chessboard.board["a7"], assassination_target
  end


end

class ChessPieceTest < Minitest::Test

  def test_pawns_starting_position_is_valid
    assert_raises(ArgumentError) do
      Pawn.new('white', "z9")
    end
  end

  def test_pawns_can_only_be_white_or_black
    # skip
    assert_raises(ArgumentError) do
      Pawn.new('green', "b1")
    end
  end

  def test_white_pawn_can_move_2_fields_if_in_starting_position
    # skip
    pawn = Pawn.new('white', "b2")
    pawn.move('b4')
    assert_equal [1,3], pawn.position
  end

  def test_white_pawn_can_move_1_field_if_in_starting_position
    # skip
    pawn = Pawn.new('white', "b2")
    pawn.move('b3')
    assert_equal [1,2], pawn.position
  end

  def test_white_pawn_moves_1_field_if_in_any_other_position
    # skip
    pawn = Pawn.new('white', "b5")
    pawn.move('b6')
    assert_equal [1,5], pawn.position
  end

  def test_black_pawn_moves_2_fields_if_in_starting_position
    # skip
    pawn = Pawn.new('black', "b7")
    pawn.move('b5')
    assert_equal [1,4], pawn.position
  end

  def test_black_pawn_moves_1_field_if_in_any_other_position
    # skip
    pawn = Pawn.new('black', "a6")
    pawn.move('a5')
    assert_equal [0,4], pawn.position
  end

  def test_pawn_cant_make_invalid_moves
    # skip
    assert_raises(InvalidMoveError) do
    pawn = Pawn.new('white', "b6")
    pawn.move('e7')
    end
  end

  def test_rook_starting_position_is_valid
    # skip
    assert_raises(ArgumentError) do
      Rook.new('white', "z9")
    end
  end

  def test_rook_can_only_be_black_or_white
    # skip
    assert_raises(ArgumentError) do
      Rook.new('potato', "z9")
    end
  end

  def test_rook_can_move_diagonal
    # skip
    rook = Rook.new('black', "a1")
    rook.move('A8')
    assert_equal [0,7], rook.position
  end

  def test_rook_can_move_horizontal
    # skip
    rook = Rook.new('black', "a1")
    rook.move('h1')
    assert_equal [7,0], rook.position
  end

  def rook_cant_move_across
    # skip
    assert_raises(InvalidMoveError) do
      rook = Rook.new('black', "c3")
      rook.move('d4')
    end
  end

  def test_bishop_starting_position_is_valid
    # skip
    assert_raises(ArgumentError) do
      Bishop.new('white', "z9")
    end
  end

  def test_bishop_can_move_diagonal
    # skip
    bishop = Bishop.new('black', "C3")
    bishop.move('d4')
    bishop.move('g7')
    bishop.move('d4')
    assert_equal [3,3], bishop.position
  end

  def test_bishop_cant_move_straight
    # skip
    assert_raises(InvalidMoveError) do
      bishop = Bishop.new('black', "c3")
      bishop.move('c4')
    end
  end

  def test_knight_can_move_the_knightly_way
    # skip
    knight = Knight.new('white', "d5")
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
      knight = Knight.new('white', "c1")
      knight.move('c2')
    end
  end

  def test_king_can_move_the_kingly_way
    # skip
    king = King.new('white', "c1")
    king.move('d1')
    king.move('e1')
    king.move('e2')
    king.move('d3')
    assert_equal [3, 2], king.position
  end

  def test_king_cant_move_like_someone_on_a_horse_or_something
    # skip
    assert_raises(InvalidMoveError) do
      king = King.new('white', "C1")
      king.move('c4')
    end
  end

  def test_queen_doesnt_walk_she_struts
    # skip
    queen = Queen.new('white', "c1")
    queen.move('d1')
    queen.move('g4')
    queen.move('g7')
    queen.move('d7')
    queen.move('d3')
    assert_equal [3, 2], queen.position
  end

  def test_queen_cant_go_where_she_cant_go
    # skip
    assert_raises(InvalidMoveError) do
      queen = Queen.new('white', "c1")
      queen.move('D4')
    end
  end
end

