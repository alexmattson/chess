require_relative 'board.rb'
require_relative 'cursorable.rb'

require 'colorize'

class Display
  include Cursorable
  attr_reader :board
  attr_accessor :selected, :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = nil
    @grid = board.grid
  end

  def move(new_pos)
  end

  def render(color)
    system('clear')
    puts "   A  B  C  D  E  F  G  H"
    @grid.each_with_index do |row,idx1|
      print "#{idx1+1} "
      row.each_with_index do |pos,idx2|
          if [idx1,idx2] == @cursor_pos
            print pos.to_s.colorize(:color => :black, :background => :red)
          elsif [idx1,idx2] == @selected
            print pos.to_s.colorize(:color => :black, :background => :green)
          elsif !@selected.nil? && @board[@selected].valid_moves.include?([idx1,idx2]) &&
                @board[@selected].color == color
            print pos.to_s.colorize(:color => :black, :background => :green)
          elsif @board[@cursor_pos].valid_moves.include?([idx1,idx2]) &&
                @board[@cursor_pos].color == color &&
                @selected.nil?
            print pos.to_s.colorize(:color => :black, :background => :green)
          elsif (idx1 + idx2).odd?
            print pos.to_s.colorize(:color => :black, :background => :yellow)
          else
            print pos.to_s.colorize(:color => :black, :background => :blue)
          end

      end
      print " #{idx1+1}"
      if idx1 == 6
        @board.taken_pieces.each do |piece|
          print piece.to_s if piece.color == :black
        end
      end
      if idx1 == 7
        @board.taken_pieces.each do |piece|
          print piece.to_s if piece.color == :white
        end
      end
      puts ""
    end
    puts "   A  B  C  D  E  F  G  H"
  end

  def select_piece
    @selected = @cursor_pos
  end

  def reset!
    @selected = nil
  end

  private

  def notifications
  end

end
