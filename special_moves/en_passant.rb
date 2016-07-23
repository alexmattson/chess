module EnPassant
  attr_accessor :en_passant, :last_move

  def en_passant_initialization
    @last_move = [0,0]
    @en_passant = false
  end

  def en_passant!(start, end_pos)
    piece = self[start]
    self[end_pos] = piece
    self[start] = NullPiece.instance
  end

  def en_passant_update_positions(start, end_pos)
    self[end_pos].position = end_pos
    self[end_pos].moved = true
    taken_pieces << self[@last_move]
    self[@last_move] = NullPiece.instance
  end

  def en_passant?(start, end_pos)
    if self[@last_move].is_a?(Pawn) && self[start].is_a?(Pawn)
      if    self[@last_move].color == :black &&
            self[@last_move].position[0] == 3
            return true if @last_move[1] == end_pos[1] &&
                           @last_move[0] - 1 == end_pos[0]
      elsif self[@last_move].color == :white &&
            self[@last_move].position[0] == 4
            return true if @last_move[1] == end_pos[1] &&
                           @last_move[0] + 1 == end_pos[0]
      end
    end
    false
  end

  def en_passant_helper(start, end_pos)
    @last_move = end_pos
    @en_passant = false
    if self[end_pos].is_a?(Pawn)
      if (self[end_pos].color == :black && start[0] == 1) ||
         (self[end_pos].color == :white && start[0] == 6)
         @en_passant = true
      end
    end
  end

end
