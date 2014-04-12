require 'rspec'
require 'stock_picker'

describe 'stock_picker' do
  let(:prices) { [10,4,3,6,23] }

  it 'returns an array of two days' do
    expect(stock_picker(prices)).to have(2).items
  end

  it 'returns the indices of the most profitable days to buy then sell' do
    expect(stock_picker(prices)).to eq([2,4])
  end
end