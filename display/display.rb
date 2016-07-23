require_relative '../board.rb'
require_relative 'cursorable.rb'

require 'colorize'

class Display
  include Cursorable
  attr_reader :board
  attr_accessor :selected, :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [6,4]
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
          # cursor position
          if [idx1,idx2] == @cursor_pos
            print pos.to_s.colorize(:color => pos.color, :background => :red)

          # selected piece
          elsif [idx1,idx2] == @selected
            print pos.to_s.colorize(:color => pos.color, :background => :green)

          # valid moves of selected piece (only works if piece selected)
          elsif !@selected.nil? && @board[@selected].valid_moves.include?([idx1,idx2]) &&
                @board[@selected].color == color
            print pos.to_s.colorize(:color => pos.color, :background => :yellow)

          # valid moves on hover (only works if no piece is selected)
          elsif @board[@cursor_pos].valid_moves.include?([idx1,idx2]) &&
                @board[@cursor_pos].color == color &&
                @selected.nil?
            print pos.to_s.colorize(:color => pos.color, :background => :yellow)

          # coloring normal spaces
          elsif (idx1 + idx2).odd?
              print pos.to_s.colorize(:color => pos.color, :background => :cyan)
          else
              print pos.to_s.colorize(:color => pos.color, :background => :light_blue)
          end

      end
      print " #{idx1+1}  "

      if (idx1 == 0 && color == :black) || (idx1 == 7 && color == :white)
        print "It's #{color}'s turn"
      end

      # taken black pieces
      if idx1 == 6
        @board.taken_pieces.each do |piece|
          if piece.color == :black
            print piece.to_s.colorize(:color => :black, :background => :white)
          end
        end
      end

      # taken white pieces
      if idx1 == 1
        @board.taken_pieces.each do |piece|
          if piece.color == :white
            print piece.to_s.colorize(:color => :white, :background => :black)
          end
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

  def intro
    system("clear")
    puts '  ____ _   _ _____ ____ ____  '
    puts ' / ___| | | | ____/ ___/ ___| '
    puts '| |   | |_| |  _| \___ \___ \ '
    puts '| |___|  _  | |___ ___) |__) |'
    puts ' \____|_| |_|_____|____/____/ '
    puts '    a game by Alex Mattson    '
    puts '------------------------------'
  end

  def game_options
    puts "Choose game a type:"
    puts "1 - Human vs Human"
    puts "2 - Human vs Computer"
    puts "3 - Computer vs Computer"
  end

  private

  def notifications
  end

end
