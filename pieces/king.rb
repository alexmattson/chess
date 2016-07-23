require_relative 'piece.rb'
require_relative 'rook.rb'
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

  def moves
    base = base_moves
    base += castling_moves
  end

  def castling_moves
    possible = []
    if @moved == false
      Rook::STARTING_POS.each do |space|
        if possible_castle?(space)
          possible << space
        end
      end
    end
    possible
  end

  private

  def possible_castle?(pos)
    piece = @board[pos]
    piece.is_a?(Rook) &&
    piece.color == @color &&
    piece.moved == false &&
    clear_path?(pos)
  end

  def clear_path?(rook_pos)
    row = @position[0]
    if @position[1] > rook_pos[1]
      cols = (rook_pos[1] + 1...@position[1])
    else
      cols = (@position[1] + 2...rook_pos[1])
    end
    cols.each do |col|
      return false unless @board[[row, col]].is_a?(NullPiece)
    end
    true
  end

end
