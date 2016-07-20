require_relative 'pieces/pawn.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/knight.rb'
require_relative 'pieces/bishop.rb'
require_relative 'pieces/queen.rb'
require_relative 'pieces/king.rb'
require_relative 'pieces/nullpiece.rb'

class Board
  attr_reader :grid, :taken_pieces

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    @taken_pieces = []
    set_board
  end

  def set_board
    set_pieces
  end

  def [](position)
    x,y = position
    @grid[x][y]
  end

  def []=(position, value )
    x,y = position
    @grid[x][y] = value
  end

  def move_piece(start, end_pos, turn_color)
    raise 'from position is empty' if self[start].empty?
    piece = self[start]
    if piece.color != turn_color
      raise 'You must move your own piece'
    elsif !piece.moves.include?(end_pos)
      raise 'Piece does not move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot move into check'
    end
    taken_pieces << self[end_pos] if taking_piece?(end_pos,turn_color)

    move_piece!(start, end_pos)
  end

  def move_piece!(start, end_pos)
    piece = self[start]
    self[end_pos] = piece
    self[start] = NullPiece.instance
    piece.position = end_pos
  end

  def taking_piece?(end_pos, color)
    self[end_pos].color != color
  end

  def check_mate?(color)
    return false unless in_check?(color)
    pieces.any? do |piece|
      piece.color == color && piece.moves.length == 0
    end
  end

  #finding check
  def in_check?(color)
    king_pos = find_king(color)
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def find_king(color)
    @grid.each do |row|
      row.each do |space|
        return space.position if space.is_a?(King) && space.color == color
      end
    end
  end

  def pieces
    pieces = []
    @grid.each do |row|
      row.each do |pos|
        pieces << pos unless pos.empty?
      end
    end
    pieces
  end

  def in_bounds?(pos)
    return false if pos[0] > 7 || pos[0] < 0
    return false if pos[1] > 7 || pos[1] < 0
    true
  end

  def set_pieces
      set_pawns
      set_rook
      set_knight
      set_bishop
      set_queen
      set_king
      set_null_piece
  end

  def set_null_piece
    (2..5).each do |row|
      @grid[row].map! { |pos| pos = NullPiece.instance }
    end
  end

  def set_pawns
    @grid[1].each_with_index { |pos,index| @grid[1][index] = Pawn.new(:black, [1,index], self) }
    @grid[6].each_with_index { |pos,index| @grid[6][index] = Pawn.new(:white, [6,index], self) }
  end

  def set_rook
    @grid[0][7] =  Rook.new(:black, [0,7], self)
    @grid[0][0] =  Rook.new(:black, [0,0], self)
    @grid[7][7] =  Rook.new(:white, [7,7], self)
    @grid[7][0] =  Rook.new(:white, [7,0], self)
  end

  def set_knight
    @grid[0][6] =  Knight.new(:black, [0,6], self)
    @grid[0][1] =  Knight.new(:black, [0,1], self)
    @grid[7][6] =  Knight.new(:white, [7,6], self)
    @grid[7][1] =  Knight.new(:white, [7,1], self)
  end

  def set_bishop
    @grid[0][5] =  Bishop.new(:black, [0,5], self)
    @grid[0][2] =  Bishop.new(:black, [0,2], self)
    @grid[7][5] =  Bishop.new(:white, [7,5], self)
    @grid[7][2] =  Bishop.new(:white, [7,2], self)
  end

  def set_queen
    @grid[0][3] = Queen.new(:black, [0,3], self)
    @grid[7][3] = Queen.new(:white, [7,3], self)
  end

  def set_king
    @grid[0][4] = King.new(:black, [0,4], self)
    @grid[7][4] = King.new(:white, [7,4], self)
  end

end
