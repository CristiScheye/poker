require 'card_value'

class Card
  attr_reader :suit, :value
  include CardValue

  def initialize(suit, value)
    @suit, @value = suit, value
  end

  def point_value
    CARD_POINTS[value]
  end

  def suit_rank
    SUIT_RANK.index(suit)
  end
end