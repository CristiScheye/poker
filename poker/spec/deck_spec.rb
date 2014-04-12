require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  its(:cards) { should have(52).cards }

  describe '#shuffle!' do
    it 'shuffles the deck' do
      shuffled_deck = Deck.new
      shuffled_deck.shuffle!
      expect(shuffled_deck.cards).to_not eq(deck.cards)
    end
  end

  describe '#draw!' do
    let!(:last_cards) { deck.cards[-2..-1] }
    let!(:drawn_cards) { deck.draw!(2) }

    it 'removes n cards from the deck' do
      expect(deck.cards).to have(50).cards
    end

    it 'returns n cards from the deck' do
      expect(drawn_cards).to have(2).cards
    end

    it 'returns an array of card objects' do
      expect(drawn_cards).to match_array(last_cards)
    end
  end


end