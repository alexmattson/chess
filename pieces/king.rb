require_relative 'piece.rb'
require_relative 'stepable.rb'
require 'byebug'

class King < Piece
  include Stepable

  def initialize(color, position, board)
    super
    set_unicode
  end

  def set_unicode
    @unicode ="\u265A" 
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

  # def moves
  #   debugger
  #   base_moves += castling_moves
  # end
  #
  # def castling_moves
  #   []
  # end
end
