module Castling
  def castling!(start, end_pos)
    king = self[start]
    rook = self[end_pos]

    king_end, rook_end = get_rook_and_king_movement(start, end_pos)

    self[king_end] = king
    self[rook_end] = rook
    self[end_pos] = NullPiece.instance
    self[start] = NullPiece.instance
    king.position = king_end
    rook.position = rook_end
  end

  def castling?(start, end_pos)
    return false unless self[start].is_a?(King) && self[end_pos].is_a?(Rook)
    return false unless self[start].moved == false &&
                        self[end_pos].moved == false
    true
  end

  def get_rook_and_king_movement(start, end_pos)
    if start[1] > end_pos[1]
      king_end = [start[0], start[1] - 2]
      rook_end = [start[0], start[1] - 1]
    else
      king_end = [start[0], start[1] + 2]
      rook_end = [start[0], start[1] + 1]
    end
    [king_end, rook_end]
  end

  def castling_update_positions(start, end_pos)
    king_end, rook_end = get_rook_and_king_movement(start, end_pos)
    self[king_end].moved = true
    self[rook_end].moved = true
  end


end
