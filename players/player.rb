class Player
  attr_reader :color, :name

  def initialize(name, color, display)
    @display = display
    @name = name
    @color = color
  end

  def get_action(display)
  end

end
