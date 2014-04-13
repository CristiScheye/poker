require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new('Bob') }
  its(:name) { should eq 'Bob' }
  its(:pot) { should eq 500 }
  its(:hand) { should be_a(Hand) }

  describe '#cards_to_replace' do
    xit 'returns the cards a player would like to replace' do
      expect(player.cards_to_replace).to be_a(Array)
    end
  end

  describe '#render_status' do

    it 'shows current pot value and cards in hand' do
      card1 = double('card')
      card2 = double('card')
      allow(card1).to receive(:render).and_return('ace of diamonds')
      allow(card2).to receive(:render).and_return('ten of spades')

      player.hand.cards = [card1, card2]
      expect(player.render_status).to eq("#{player.name} has $#{player.pot}.\nCards in hand:\nace of diamonds\nten of spades")
    end
  end

end
