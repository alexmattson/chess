require 'singleton'

class NullPiece
  include Singleton

  def to_s
    "   "
  end

  def color
  end

  def empty?
    true
  end

  def valid_moves
    []
  end

  def moves
    []
  end

end
