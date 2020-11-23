# frozen_string_literal: true

require_relative '../card'

# Deck
# variables:
#   cards - array of all cards in deck
# methods:
#   initialize(Array of cards) - constructor
#   draw_card - return and remove the top card from deck
#   put_card(Card) - add card to deck
#   shuffle - return shuffled deck without saving
#   shuffle! - return shaffled deck and save it
class Deck
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def draw_card
    cards.pop
  end

  def put_card(card)
    cards << card
  end

  def clear
    self.cards = []
  end

  def shuffle
    Deck.new(cards.shuffle(random: Random.new))
  end

  def shuffle!
    cards.shuffle!(random: Random.new)
    self
  end

  protected

  attr_writer :cards
end
