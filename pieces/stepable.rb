module Stepable

  def moves
    possible = []
    move_diffs.each do |move|
      row = @position[0]
      col = @position[1]
      new_row = row + move[0]
      new_col = col + move[1]
      if on_board(new_row, new_col) &&
      (@board[[new_row, new_col]].is_a?(NullPiece) ||
       @board[[new_row, new_col]].color != @color)
        possible << [new_row, new_col]
      end
    end
    possible
  end

  private

  def on_board(row, col)
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end

  def move_diffs
  end
end
