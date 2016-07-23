# to extend the game and add more special moves just do the following:
# 1 - require_relative
# 2 - include
# 3 - add to ADDONS

require_relative 'castling.rb'
require_relative 'en_passant.rb'
require_relative 'pawn_promotion.rb'

require 'byebug'

module SpecialMoves
  include Castling
  include EnPassant
  include PawnPromotion

  ADDONS = ["castling",
            "en_passant",
            "pawn_promotion"]

  def run_special_moves_initializations
    ADDONS.each do |special|
      send("#{special}_initialization".to_sym)
    end
  end

  def handle_special_move(start, end_pos)
    type = get_type(start, end_pos)
    params = [start, end_pos]
    handle_special_move!(start, end_pos)
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

  def special_move_helpers(start, end_pos)
    params = [start, end_pos]
    ADDONS.each do |special|
      send("#{special}_helper".to_sym, *params)
    end
  end

  private

  def get_type(start, end_pos)
    params = [start, end_pos]
    ADDONS.each do |special|
      return special if send("#{special}?".to_sym, *params)
    end
    nil
  end




end
