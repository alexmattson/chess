require_relative '../../dependencies/pieces.rb'
require_relative '../player.rb'

class ComputerPlayer < Player
  VALUES = {Queen.new(nil,nil,nil) => 9,
            Rook.new(nil,nil,nil) => 5,
            Bishop.new(nil,nil,nil) => 3,
            Knight.new(nil,nil,nil) => 3,
            Pawn.new(nil,nil,nil) => 1}

  def initialize(name, color, display)
    super
  end

  def get_action(display)
    if @display.selected.nil?
      @display.cursor_pos = get_selection
    else
      @display.cursor_pos = get_move
    end
    true
  end

  def get_pawn_promotion
    return "queen"
  end


#get selection
  def get_selection
    op = own_pieces
    om = opponents_moves
    VALUES.keys.each do |k|
      op.each do |piece|
        return piece.position if piece_threatened?(piece,k,om) && !piece.valid_moves.empty?
        return piece.position if able_to_capture?(piece)
      end
    end
    choose_random(op)
  end

  def piece_threatened?(piece,k,om)
    piece.class == k.class && om.include?(piece.position)
  end

  def able_to_capture?(piece)
    piece.valid_moves.any? do |pos|
      @display.board[pos].is_a?(NullPiece) &&
      @display.board[pos].color == @color
    end
  end

  def get_move
    piece = @display.board[@display.selected]
    piece.valid_moves.each do |pos|
      if !@display.board[pos].is_a?(NullPiece) &&
          @display.board[pos].color != @color
         return pos
      end
    end
    choose_random_valid_move(piece)
  end

  def choose_random(pieces)
    possible = pieces.select{ |piece| piece.valid_moves.length > 0}
    possible.shuffle.first.position
  end

  def choose_random_valid_move(piece)
    possible = piece.valid_moves
    possible.shuffle.first
  end

  def opponents_moves
    moves = []
    opponents_pieces.each do |piece|
      moves += piece.valid_moves
    end
    moves
  end

  def opponents_pieces
    pieces.select{|piece| piece.color != @color}
  end

  def own_pieces
    pieces.select{|piece| piece.color == @color}
  end
  def pieces
    pieces = []
    @display.board.grid.each do |row|
      row.each do |pos|
        pieces << pos unless pos.empty?
      end
    end
    pieces
  end

end
