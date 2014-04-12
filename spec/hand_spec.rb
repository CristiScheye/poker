require 'rspec'
require 'hand'


describe Hand do
  subject(:hand) { Hand.new }
  its(:cards) { should have(5).cards }

  let!(:s_a) {Card.new(:spade, :ace)}
  let!(:s_k) {Card.new(:spade, :king)}
  let!(:s_q) {Card.new(:spade, :queen)}
  let!(:s_j) {Card.new(:spade, :jack)}
  let!(:s_10) {Card.new(:spade, :ten)}
  let!(:s_9) {Card.new(:spade, :nine)}
  let!(:d_9) {Card.new(:diamond, :nine)}

  describe '#flush?' do
    it 'returns true if all cards have same suit' do
      hand.cards = [s_a] * 5
      expect(hand).to be_flush
    end
  end

  describe '#straight?' do
    it 'returns true if card values increment by one' do
      hand.cards = [s_a, s_k, s_q, s_j, s_10]
      expect(hand).to be_straight
    end
  end

  describe "#rank" do

    context 'when hand is royal flush' do
      it 'returns 9' do
        hand.cards = [s_a, s_k, s_q, s_j, s_10]
        expect(hand.rank).to eq(9)
      end
    end

    context 'when hand is straight flush' do
      it 'returns 8' do
        hand.cards = [s_k, s_q, s_j, s_10, s_9]
        expect(hand.rank).to eq(8)
      end
    end

    context 'when hand is a four of a kind' do
      it 'return 7' do
        hand.cards = [s_a] * 4 + [s_j]
        expect(hand.rank).to eq(7)
      end
    end

    context 'when hand is a full house' do
      it 'return 6' do
        hand.cards = [s_a] * 3 + [s_j] * 2
        expect(hand.rank).to eq(6)
      end
    end

    context 'when hand is a flush' do
      it 'returns 5' do
        hand.cards = [s_k] * 5
        expect(hand.rank).to eq(5)
      end
    end

    context 'when hand is straight' do
      it 'returns 4' do
        hand.cards = [s_k, s_q, s_j, s_10, d_9]
        expect(hand.rank).to eq(4)
      end
    end

    context 'when hand is a three of a kind' do
      it 'return 3' do
        hand.cards = [s_a] * 3 + [s_j, d_9]
        expect(hand.rank).to eq(3)
      end
    end

    context 'when hand is a two pairs' do
      it 'return 2' do
        hand.cards = [s_a] * 2 + [s_j] * 2 + [d_9]
        expect(hand.rank).to eq(2)
      end
    end

    context 'when hand is a one pair' do
      it 'return 1' do
        hand.cards = [s_a] * 2 + [s_j, s_q, d_9]
        expect(hand.rank).to eq(1)
      end
    end

    context 'when hand is a no pair' do
      it 'return 0' do
        hand.cards = [s_a, s_10, s_j, s_q, d_9]
        expect(hand.rank).to eq(0)
      end
    end
  end

  describe '#highest_card' do
    context 'when all cards in hand are scoring cards' do
      it 'returns highest card' do
        hand.cards = [s_a, s_k, s_q, s_j, s_10]
        expect(hand.highest_card).to eq(s_a)
      end
    end

    context 'when only a subset of cards are scoring cards' do
      it 'returns the highest card' do
        hand.cards = [d_9] * 2 + [s_j] * 2 + [s_a]
        expect(hand.highest_card).to eq(s_j)
      end
    end
  end

  describe "beats?" do
    let!(:hand1) { Hand.new }
    let!(:hand2) { Hand.new }

    context 'when the two hands have different ranks' do
      it 'compares the rankings' do
        hand1.stub(:rank).and_return(9)
        hand2.stub(:rank).and_return(8)
        expect(hand1.beats?(hand2)).to be_true
      end
    end

    context 'when the two hands have same rank' do
      context 'when two hands have different high value' do
        it 'compares the high values' do
          hand1.stub(:rank).and_return(9)
          hand2.stub(:rank).and_return(9)
          hand1.stub(:highest_card).and_return(Card.new(:heart,:queen))
          hand2.stub(:highest_card).and_return(Card.new(:heart,:jack))
          expect(hand1.beats?(hand2)).to be_true
        end
      end
      context 'when two hands have same high value' do
        it 'compares suits' do
          hand1.stub(:rank).and_return(9)
          hand2.stub(:rank).and_return(9)
          hand1.stub(:highest_card).and_return(Card.new(:spade,:queen))
          hand2.stub(:highest_card).and_return(Card.new(:heart,:queen))
          expect(hand1.beats?(hand2)).to be_true
        end
      end
    end

  end

end
