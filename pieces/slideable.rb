module Slideable

  def moves
    possible_moves = []
    possible_moves += horizontal_dirs if move_dirs[0]
    possible_moves += diagonal_dirs if move_dirs[1]
    possible_moves
  end

  private

  def move_dirs
    [horizontal_dirs, diagonal_dirs]
  end

  def horizontal_dirs
    delta = [[0, 1], [-1, 0], [0, -1], [1, 0]]
    look_out(delta)
  end

  def diagonal_dirs
    delta = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    look_out(delta)
  end

  def look_out(delta,
               current = [@position, @position, @position, @position],
               hit = [false, false, false, false])
    possible = []
    check_positions = next_pos(current,delta)
    check_positions.each_with_index do |pos,i|
      next if hit[i]
      (hit[i] = true; next) if hit_edge?(pos)
      if hit_piece?(pos)
        possible << pos if not_your_piece(pos)
        hit[i] = true
        next
      end
      possible << pos
    end
    possible += look_out(delta,check_positions, hit) if hit.include?(false)
    possible
  end

  def next_pos(current,delta)
    final = []
    current.each_with_index do |pos,i|
      final << [pos[0] + delta[i][0], pos[1] + delta[i][1]]
    end
    final
  end

  def hit_edge?(position)
    row, col = position
    row < 0 || col < 0 || row > 7 || col > 7
  end

  def hit_piece?(position)
    !@board[position].is_a?(NullPiece)
  end

  def not_your_piece(position)
    @board[position].color != @color
  end

end
