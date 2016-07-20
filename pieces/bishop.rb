require_relative 'piece.rb'
require_relative 'slideable.rb'

class Bishop < Piece
  include Slideable

  def initialize(color, position, board)
    super
    set_unicode
  end

  def set_unicode
    @unicode = @color == :black ? "\u265D" : "\u2657"
  end

  def to_s
    " #{@unicode.encode('utf-8')} "
  end

  protected

  def move_dirs
    [false, true]
  end
end
