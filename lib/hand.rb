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
    card_vals = cards.map {|card| VALUES.index(card.value) } #array of indices in VALUES

    #if the hand *might* be a high straight, make its only ace high
    if card_vals.include?(12) && card_vals.include?(0)
      card_vals[card_vals.index(0)] = 13
    end

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
    max_freq_vals = card_val_frequency.select{ |k, v| v == max_freq }.keys

    sorted_high_vals = VALUES.select {|val| max_freq_vals.include?(val)}

    #if the hand has kings and aces, put the aces last
    if sorted_high_vals.include?(:ace) && sorted_high_vals.include?(:king)
      sorted_high_vals << sorted_high_vals.shift
    end

    highest_val = sorted_high_vals.last

    high_cards = cards.select {|card| card.value == highest_val}
    high_cards.last
  end


  def rank
    card_freq = card_val_frequency
    if flush? && straight? && cards.any? {|c| c.value == :ace }
      return 9
    elsif flush? && straight?
      return 8
    elsif card_freq.has_value?(4)
      return 7
    elsif card_freq.has_value?(3) && card_freq.has_value?(2)
      return 6
    elsif flush?
      return 5
    elsif straight?
      return 4
    elsif card_freq.has_value?(3)
      return 3
    elsif card_freq.has_value?(2) && card_freq.keys.size == 3
      return 2
    elsif card_freq.has_value?(2)
      return 1
    end
    0
  end

end
