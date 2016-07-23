require_relative 'piece.rb'
require_relative 'stepable.rb'

class Knight < Piece
  include Stepable

  def initialize(color, position, board)
    super
    set_unicode
  end

  def set_unicode
    @unicode = "\u265E"
  end

  def to_s
    " #{@unicode.encode('utf-8')} "
  end

  def move_diffs
   [[-1,-2],
    [-1, 2],
    [ 1,-2],
    [ 1, 2],
    [-2,-1],
    [-2, 1],
    [ 2,-1],
    [ 2, 1]]
  end

  def moves
    base_moves
  end
end
