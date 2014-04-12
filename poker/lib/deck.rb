require_relative 'card'

class Deck
  attr_reader :cards

  SUITS = [:heart, :diamond, :spade, :club]
  VALUES = [:ace, :two, :three, :four, :five,
    :six, :seven, :eight, :nine, :ten, :jack, :queen, :king]

  def initialize
    @cards = SUITS.product(VALUES).map {|value| Card.new(value.first, value.last)}
  end

  def shuffle!
    cards.shuffle!
  end

  def draw!(num_cards)
    drawn_cards = []
    num_cards.times do
      drawn_cards << cards.pop
    end
    drawn_cards
  end
end