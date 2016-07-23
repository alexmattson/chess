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
    possible += en_passant
  end


  private

  def en_passant
    possible = []
    return possible unless en_passant?
    if @color == :white
      if @board.last_move[1] > @position[1]
        possible << [@position[0] - 1, @position[1] + 1]
      else
        possible << [@position[0] - 1, @position[1] - 1]
      end
    else
      if @board.last_move[1] > @position[1]
        possible << [@position[0] + 1, @position[1] + 1]
      else
        possible << [@position[0] + 1, @position[1] - 1]
      end
    end
  end

  def en_passant?
    return false unless @board.en_passant
    return false if @board[@board.last_move].color == @color
    if @color == :white
      return true if (@board.last_move[1] + 1 == @position[1]  ||
                      @board.last_move[1] - 1 == @position[1]) &&
                      @board.last_move[0] == @position[0]
    else
      return true if (@board.last_move[1] + 1 == @position[1]  ||
                      @board.last_move[1] - 1 == @position[1]) &&
                      @board.last_move[0] == @position[0]
    end
    false
  end

  def set_unicode
    @unicode =  "\u265F"
  end

  #move helpers
  def home_row
    home_row = []
    return home_row if @moved
    row = @position[0]
    col = @position[1]
    if @color == :black
      return home_row if row > 3
      if @board[[row+1, col]].empty? &&
         @board[[row+2, col]].empty?
        home_row << [row + 2, col]
      end
    else
      return home_row if row < 4
      if @board[[row-1, col]].empty? &&
         @board[[row-2, col]].empty?
         home_row << [row - 2, col]
       end
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
    return possible_attacks if row == 7 || row == 0
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
