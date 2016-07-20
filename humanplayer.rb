require_relative 'player.rb'

class HumanPlayer < Player

  def initialize(name, color, display)
    super
  end

  def get_action(display)
    display.get_input
  end

end
