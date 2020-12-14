# frozen_string_literal: true

# Card
# variables:
#   value, suit
# methods:
#   initialize(value, suit) - constructor
#   points - returns points given by this card
class Card
  attr_reader :value, :suit

  # all possible card values with points
  VALUES_POINTS =
    { two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9,
      ten: 10,
      jack: 10,
      queen: 10,
      king: 10,
      ace: 1 }.freeze

  # all possible card suits
  SUITS = %i[spades diamonds clubs hearts].freeze

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def points
    VALUES_POINTS[value]
  end
end
