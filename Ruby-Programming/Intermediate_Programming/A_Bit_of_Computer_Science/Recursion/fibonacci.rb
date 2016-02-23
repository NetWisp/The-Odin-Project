# The Fibonacci Sequence, which sums each number with the one before it,
# is a great example of a problem that can be solved recursively.

# Take a number and returns that many members of the fibonacci sequence.
# Use iteration for this solution
def fibs(num)
  first_num = 0
  second_num = 1

  if num == 0
    0
  elsif num == 1
    1
  else
    for i in 0..num - 2   # account for the starting numbers
      temp = second_num
      second_num = first_num + second_num
      first_num = temp
    end
    return second_num
  end
end

# Solves the same problem recursively
def fibs_rec(num)
  if num == 0
    0
  elsif num == 1
    1
  else
    fibs_rec(num -1) + fibs_rec(num -2)
  end
end

num = 9
puts "Testing fibs function: "
puts fibs(num)
puts ""

puts "Testing fibs_rec function: "
puts fibs_rec(num)
