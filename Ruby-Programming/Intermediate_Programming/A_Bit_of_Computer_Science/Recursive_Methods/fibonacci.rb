def fibonacci_value(position)
  if position == 0
    0
  elsif position == 1
    1
  else
    fibonacci_value(position - 1) + fibonacci_value(position - 2)
  end
end

puts fibonacci_value(3)
