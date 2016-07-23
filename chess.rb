require_relative 'dependencies/dependencies.rb'

class Chess

  def initialize
    @board = Board.new
    @display = Display.new(@board)

    @display.intro
    @players = set_players
    @current_player = @players[0]
  end

  def play
    until @board.check_mate?(@current_player.color)
      make_move
    end
    # loop do
    #   make_move
    # end
    @display.render(@current_player.color)
    puts "#{@current_player.name} won!"
  end

  private

  def set_players
    @display.game_options
    case gets.chomp
    when "1"
      @players = [HumanPlayer.new("white",:white,@display), HumanPlayer.new("black", :black,@display)]
    when "2"
      @players = [HumanPlayer.new("white",:white,@display), ComputerPlayer.new("black", :black,@display)]
    when "3"
      @players = [ComputerPlayer.new("white",:white,@display), ComputerPlayer.new("black", :black,@display)]
    end
  end

  #handle move
  def make_move
    loop do
      @display.render(@current_player.color)
      unless @current_player.get_action(@display).nil? # this is checking for return key
        break
      end
    end
    @display.select_piece
    loop do
      @display.render(@current_player.color)
      unless @current_player.get_action(@display).nil? # this is checking for return key
        move_to
        break
      end
    end
    swap_turn!
  # rescue StandardError => e
  #   puts e
  #   sleep 1
  #   @display.reset!
  #   retry
  end

  def move_to
    start = @display.selected
    finish = @display.cursor_pos
    return @board.move_piece(start, finish, @current_player.color)
  end

  #handle turn
  def swap_turn!
    @display.selected = nil
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

end

Chess.new.play
