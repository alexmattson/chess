require_relative 'piece.rb'
require_relative 'stepable.rb'

class King < Piece
  include Stepable

  def initialize(color, position, board)
    super
    set_unicode
  end

  def set_unicode
    @unicode = @color == :black ? "\u265A" : "\u2654"
  end

  def to_s
    " #{@unicode.encode('utf-8')} "
  end

  def move_diffs
   [[ 0, 1],
    [ 1, 0],
    [-1, 0],
    [ 0,-1],
    [-1, 1],
    [ 1,-1],
    [-1,-1],
    [ 1, 1]]
  end
end
