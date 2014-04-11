require 'rspec'
require 'hanoi'

describe Hanoi do
  subject(:game) { Hanoi.new }
  its(:towers) {should eq [[3,2,1], [], []]}

  describe '#move' do
    it 'moves disk from one tower to another' do
      game.move(0,1)
      expect(game.towers).to eq([[3,2], [1], []])
    end

    it 'raises exception if removal tower is empty' do
      expect { game.move(1,0) }.to raise_error("Can't remove from an empty tower")
    end

    it 'raises exception if target stack has a smaller disk' do
      game.move(0,1)
      expect {game.move(0,1)}.to raise_error("Can't place on top of a smaller disk")
    end
  end

  describe '#won?' do
    it 'returns true if last tower has all the disk' do
      game.towers = [[], [], [3, 2, 1]]
      expect(game.won?).to be_true
    end
  end

  describe '#render' do
    it 'displays towers to users' do
      expect(game.render.class).to eq(String)
    end
  end

  describe '#render' do
    it 'should display towers' do
      expect(game.render).to eq("1    \n2    \n3    ")
    end
  end
end