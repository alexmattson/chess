require_relative '../display/cursorable.rb'

module PawnPromotion

  def pawn_promotion_initialization
  end

  def pawn_promotion!(start, end_pos)
    piece = select_piece(start)
    self[end_pos] = piece
    self[start] = NullPiece.instance
  end

  def pawn_promotion_update_positions(start, end_pos)
    self[end_pos].position = end_pos
  end

  def pawn_promotion?(start, end_pos)
    return false unless self[start].is_a?(Pawn)
    (self[start].color == :black && end_pos[0] == 8) ||
    (self[start].color == :white && end_pos[0] == 0)
  end

  def pawn_promotion_helper(start, end_pos)
  end

  def select_piece(start)
    #need to still add implimentation for choosing between Queen, Rook, Bishop, and Knight
    Queen.new(self[start].color, start, self)
  end

end
