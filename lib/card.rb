require 'card_value'

class Card
  include CardValue
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit, @value = suit, value
  end

  def point_value
    value == :ace ? 13 : VALUES.index(value)
  end

  def suit_rank
    SUITS.index(suit)
  end
end
