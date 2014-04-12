def my_transpose(matrix)
  row_dim = matrix.size
  col_dim = matrix[0].size
  transposed_matrix = Array.new(col_dim) { Array.new(row_dim) }

  row_dim.times do |i|
    col_dim.times do |j|
      transposed_matrix[j][i] = matrix[i][j]
    end
  end
  transposed_matrix
end