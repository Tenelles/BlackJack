# frozen_string_literal: true

require_relative 'hand'

# Player
# variables:
#   name
#   money
#   deck
# methods:
#   initialize(String name, Int money, DPlayerDeck) - constructor
#   draw_card(Deck) - take one card from argument to it's own deck
#   points - get player's points
#   make_bet(Int) - spend some money on bet
#   take_reward(Int) - take your reward
class Player
  attr_reader :name, :money, :hand

  def initialize(name, money = 0, hand = Hand.new)
    @name = name
    @money = money
    @hand = hand
  end

  def draw_card(source_deck)
    hand.put_card(source_deck.draw_card)
  end

  def clear_hand
    hand.clear
  end

  def points
    points = hand.points
    points = 0 if points > 21
    points
  end

  def make_bet(value)
    self.money -= value
    value
  end

  def take_reward(value)
    self.money += value
    value
  end

  protected

  attr_writer :money, :hand
end
