def stock_picker(prices)
  max_profit = 0
  best_pair = [nil, nil]
  prices.each_with_index do |buy, buy_index|
    prices.each_with_index do |sell, sell_index|
      next if sell_index <= buy_index
      if sell - buy > max_profit
        max_profit = sell - buy
        best_pair = [buy_index, sell_index]
      end
    end
  end
  best_pair
end