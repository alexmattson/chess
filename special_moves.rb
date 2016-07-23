# to extend the game and add more special moves just do the following:
# 1 - require_relative
# 2 - include
# 3 - add the type to the get_type function

require_relative 'castling.rb'

require 'byebug'

module SpecialMoves
  include Castling

  def handle_special_move(start, end_pos)
    type = get_type(start, end_pos)
    handle_special_move!(start, end_pos)
    params = [start, end_pos]
    send("#{type}_update_positions".to_sym, *params)
  end

  def handle_special_move!(start, end_pos)
    type = get_type(start, end_pos)
    params = [start, end_pos]
    send("#{type}!".to_sym, *params)
  end

  def special_move?(start, end_pos)
    return false if get_type(start, end_pos).nil?
    true
  end

  private

  def get_type(start, end_pos)
    return "castling" if castling?(start, end_pos)
    nil
  end




end
