require_relative 'piece.rb'

require 'byebug'

class Pawn < Piece

  def initialize(color,position, board)
    super
    set_unicode
  end

  def to_s
    " #{@unicode.encode('utf-8')} "
  end

  def moves
    possible = []
    possible += home_row
    possible += front_open
    possible += check_attack
  end


  private

  def set_unicode
    @unicode =  "\u265F" 
  end

  #move helpers
  def home_row
    home_row = []
    row = @position[0]
    col = @position[1]
    if row == 1 &&
      @color == :black &&
      @board[[row+1, col]].color != @color &&
      @board[[row+2, col]].empty?
      home_row << [row + 2, col]
    end
    if row == 6 &&
      @color == :white &&
      @board[[row-1, col]].color != @color &&
      @board[[row-2, col]].empty?
      home_row << [row - 2, col]
    end
    home_row
  end

  def front_open
    row = @position[0]
    col = @position[1]
    if @color == :black
      return [[row + 1, col]] if (row + 1 <= 7) && @board[[row + 1, col]].is_a?(NullPiece)
    else
      return [[row - 1, col]] if (row - 1 >= 0) && @board[[row - 1, col]].is_a?(NullPiece)
    end
    []
  end

  def check_attack
    possible_attacks = []
    row = @position[0]
    col = @position[1]
    if @color == :black
      unless @board[[row + 1, col+1]].is_a?(NullPiece) || row + 1 > 7 ||  col + 1 > 7
        possible_attacks << [row+1, col+1] if @board[[row + 1, col+1]].color == :white
      end
      unless @board[[row + 1, col-1]].is_a?(NullPiece) || row + 1 > 7 ||  col - 1 < 0
        possible_attacks << [row+1, col-1] if @board[[row + 1, col-1]].color == :white
      end
    else
      unless @board[[row - 1, col+1]].is_a?(NullPiece) || row - 1 < 0 ||  col + 1 > 7
        possible_attacks << [row-1, col+1] if @board[[row - 1, col+1]].color == :black
      end
      unless @board[[row - 1, col-1]].is_a?(NullPiece) || row - 1 < 0 || col - 1 < 0
        possible_attacks << [row-1, col-1] if @board[[row - 1, col-1]].color == :black
      end
    end
    possible_attacks
  end

end
