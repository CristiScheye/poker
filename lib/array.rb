class Array
  def my_uniq
    h = Hash.new
    self.each {|el| h[el] = 1}
    h.keys
  end

  def two_sum
    results = []
    length.times do |i|
      (i + 1).upto(self.length - 1) do |j|
        results << [i, j] if self[j] + self[i] == 0
      end
    end
    results
  end
end