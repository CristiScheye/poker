require_relative 'card'
require_relative 'card_value'

class Deck
  include CardValue

  attr_reader :cards

  def initialize
    @cards = SUITS.product(VALUES).map {|value| Card.new(value.first, value.last)}
  end

  def shuffle!
    cards.shuffle!
  end

  def deal(num_cards)
    drawn_cards = []
    num_cards.times do
      drawn_cards << cards.pop
    end
    drawn_cards
  end
end
