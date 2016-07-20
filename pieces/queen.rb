require_relative 'piece.rb'
require_relative 'slideable.rb'

class Queen < Piece
  include Slideable

  def initialize(color, position, board)
    super
    set_unicode
  end

  def set_unicode
    @unicode = @color == :black ? "\u265B" : "\u2655"
  end

  def to_s
    " #{@unicode.encode('utf-8')} "
  end

  protected

  def move_dirs
    [true, true]
  end
end
