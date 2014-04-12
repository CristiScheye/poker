require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:heart, :jack) }
  its(:suit) { should eq(:heart) }
  its(:value) { should eq(:jack) }

  describe '#point_value' do
    it "returns numerical point value" do
      expect(card.point_value).to eq(10)
    end
  end

  describe '#suit_rank' do
    it 'returns numerical suit rank' do
      expect(card.suit_rank).to eq(2)
    end
  end
end
