=begin
Project 2: Stock Picker

Your Task
Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

    > stock_picker([17,3,6,9,15,8,6,1,10])
    => [1,4]  # for a profit of $15 - $3 == $12
Quick Tips:

You need to buy before you can sell
Pay attention to edge cases like when the lowest day is the last day or the highest day is the first day.
=end

def create_stock_prices
	stock_prices = []
	puts "Enter stocks for each day: (Enter -1 to end)"
	
	counter = 0 
	price = 0
	
	while (price > -1)
		print "Day #{counter}: "
		price = gets.chomp
		if Integer(price)
			price = price.to_i  
			if price >= 0
				stock_prices << price 
				counter += 1
			end
		end
	end
	stock_prices
end

def stock_picker(stock_prices)
	days = []
	buy = stock_prices.index(stock_prices.min)
	sell = stock_prices.index(stock_prices.max)
	profit = 0
	# Check if lowest price comes before highest price, if so, then done
	# Otherwise, check each scenario
	if(sell > buy)
		days << buy
		days << sell
	elsif(buy > sell)
		stock_prices[0..-2].each_with_index do |curr_buy, i|
			stock_prices[i+1..-1].each_with_index do |curr_sell, j|
				 curr_profit = sell - buy
				 if curr_profit > profit
				 	profit = curr_profit
				 	buy = curr_buy
				 	sell = curr_sell
				 end
			end
		end
		days << buy
		days << sell
	else
		days << buy
		days << sell
	end
	days
end

stock_prices = create_stock_prices
puts "\nRunning stock picker...\n\n"
days = stock_picker(stock_prices)
max_price = stock_prices[days[1]]
min_price = stock_prices[days[0]]
puts "#{days}	# for a profit of $#{max_price} - $#{min_price} == $#{max_price - min_price}"
