require 'rspec'
require 'array'

describe Array do

  describe '#my_uniq' do
    it 'removes duplicate values' do
      expect([1,2,1,3,3].my_uniq).to eq([1,2,3])
    end
  end

  describe '#two_sum' do
    it 'returns an array of pairs that sum to 0' do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
  end
end