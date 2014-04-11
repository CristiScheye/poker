class Hanoi
  attr_accessor :towers

  def initialize
    @towers = [[3,2,1], [], []]
  end

  def move(source, target)
    raise "Can't remove from an empty tower" if towers[source].empty?

    if !towers[target].empty? && (towers[source].last > towers[target].last)
      raise "Can't place on top of a smaller disk"
    end

    towers[target] << towers[source].pop
  end

  def won?
    towers == [[], [], [3,2,1]]
  end

  def render
    frame = []
    2.downto(0) do |disk|
      row = []
      towers.each do |tower|
         if tower[disk].nil?
           row << " "
         else
           row << tower[disk].to_s
         end
      end
      frame << row.join(' ')
    end
    frame.join("\n")
  end
end