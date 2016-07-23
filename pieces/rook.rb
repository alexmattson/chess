require_relative 'piece.rb'
require_relative 'slideable.rb'

class Rook < Piece
  include Slideable

  def initialize(color, position, board)
    super
    set_unicode
  end

  def set_unicode
    @unicode = "\u265C" 
  end

  def to_s
    " #{@unicode.encode('utf-8')} "
  end

  protected

  def move_dirs
    [true, false]
  end
end
