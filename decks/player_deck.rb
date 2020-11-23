# frozen_string_literal: true

require_relative 'deck'

# PlayerDeck
# implement Deck
#   points - returns points of all cards in deck
class PlayerDeck < Deck
  def points
    sum = 0
    cards.each { |card| sum += card.points }
    sum += 10 if cards.index { |card| card.value == :ace } && sum <= 11
    sum
  end
end
