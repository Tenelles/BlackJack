# frozen_string_literal: true
require_relative 'card'

# Hand
#   points - returns points of all cards in deck
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def put_card(card)
    cards << card
  end

  def clear
    self.cards = []
  end

  def points
    sum = 0
    cards.each { |card| sum += card.points }
    sum += 10 if cards.index { |card| card.value == :ace } && sum <= 11
    sum
  end

  protected
  attr_writer :cards
end
