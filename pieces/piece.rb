require 'byebug'
class Piece
  attr_accessor :position, :moved
  attr_reader :color
  def initialize(color,position, board)
    @color = color
    @position = position
    @board = board
    @moved = false
  end

  def empty?
    false
  end

  def to_sym
  end

  def moves
  end

  def valid_moves
    moves.reject{|move| move_into_check?(move) }
  end

  private
  def move_into_check?(to_pos)
    test_board = board_dup
    test_board.move_piece!(@position, to_pos)
    test_board.in_check?(color)
  end

  def board_dup
    clone = Board.new
    @board.grid.each_with_index do |el, row|
      el.each_with_index do |space, col|
        if space.is_a?(NullPiece)
          clone.grid[row][col] = NullPiece.instance
        else
          clone.grid[row][col] = space.class.new(space.color, space.position, clone)
        end
      end
    end
    clone
  end

end
