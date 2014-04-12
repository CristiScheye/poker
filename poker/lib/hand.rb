require 'card_value'

class Hand
  include CardValue

  attr_accessor :cards
  def initialize
    @cards = Array.new(5)
  end

  def beats?(other_hand)
    if rank > other_hand.rank
      return true
    elsif rank == other_hand.rank

      if highest_card.point_value > other_hand.highest_card.point_value
        return true
      elsif highest_card.point_value == other_hand.highest_card.point_value
        if highest_card.suit_rank > other_hand.highest_card.suit_rank
          return true
        end
      end
    end
    false
  end

  def flush?
    cards.all? {|card| card.suit == cards[0].suit}
  end

  def straight?
    card_vals = cards.map {|card| card.point_value }
    card_vals.sort!
    5.times do |i|
       return false if i + card_vals.min != card_vals[i]
    end
    true
  end

  def card_val_frequency
    h = Hash.new(0)
    cards.each do |card|
      h[card.value] += 1
    end
    h
  end

  def highest_card
    max_freq = card_val_frequency.values.max
    max_freq_keys = card_val_frequency.select{ |k, v| v == max_freq }.keys

  end

  def rank
    hand_status = card_val_frequency
    val = 0
    if flush? && straight? && cards.any? {|c| c.value == :ace }
      val = 9
    elsif flush? && straight?
      val = 8
    elsif hand_status.has_value?(4)
      val = 7
    elsif hand_status.has_value?(3) && hand_status.has_value?(2)
      val = 6
    elsif flush?
      val = 5
    elsif straight?
      val = 4
    elsif hand_status.has_value?(3)
      val = 3
    elsif hand_status.has_value?(2) && hand_status.keys.size == 3
      val = 2
    elsif hand_status.has_value?(2)
      val = 1
    end
    val
  end

end