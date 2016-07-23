require_relative '../player.rb'

class HumanPlayer < Player

  def initialize(name, color, display)
    super
  end

  def get_action(display)
    display.get_input
  end

  def get_pawn_promotion
    system("clear")
    puts "Pawn promotion time!"
    puts "Do you want a Queen, rook, knight, or bishop?"
    gets.chomp.downcase
  end


end
