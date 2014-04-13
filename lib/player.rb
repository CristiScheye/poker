require_relative 'hand'
require_relative 'card_value'

class Player
  include CardValue
  attr_reader :hand, :pot, :name

  def initialize(name, pot = 500)
    @name, @pot = name, pot
    @hand = Hand.new
  end

  def cards_to_replace
    cards = []
    begin
      puts 'Choose a card to discard. Press enter to finish'
      card = gets.chomp
      cards << formatted_card_choice(card) unless card == ''
    end until card == ''
    cards
  end

  def render_status
    render_str = "#{name} has $#{pot}.\nCards in hand:\n"
    card_strs = cards.map do |card|
      card.render
    end
    render_str << card_strs.join("\n")
  end

  def cards
    hand.cards
  end

  private

  def formatted_card_choice(card_input)
    card_attributes = card_input.split(' ')

    if card_attributes.size < 2
      raise 'must enter suit and value'
    end

    card_attrs = {}
    card_attributes.each do |attribute|
      if VALUES.include?(attribute.to_sym)
        card_attrs[:value] = attribute.to_sym
      elsif SUITS.include?(attribute.to_sym)
        card_attrs[:suit] = attribute.to_sym
      else
        raise 'must enter valid suit and/or value'
      end
    end

    unless card_attributes.has_key?(:value) && card_attributes.has_key?(:suit)
      raise 'must enter suit and value'
    end
    card_attrs
  end
end
