module Enumerable

  # Calls the given block once for each
  # element in self, passing that element as a parameter.
  def my_each
    for element in self
      yield(element)
    end
  end

  # Calls block with two arguments, the item and its index,
  # for each item in enum. Given arguments are passed through to each().
  def my_each_with_index
    index = 0
    for element in self
      yield(element, index)
      index += 1
    end
  end

  # Returns a new array containing
  # all elements of ary for which the given block returns a true value.
  def my_select
    arr = []
    for element in self
      if(yield(element))
        arr.push(element)
      end
    end
    arr
  end

  # Passes each element of the collection to the given block.
  # The method returns true if the block never returns false or nil.
  # If the block is not given, Ruby adds an implicit block of
  # { |obj| obj } which will cause all? to return true when none of the
  # collection members are false or nil.
  def my_all?
    result = true
    for element in self
      if ((yield(element) == false) || (yield(element) == nil))
        result = false
      end
    end
    result
  end

  # Passes each element of the collection to the given block.
  # The method returns true if the block ever returns a value other
  # than false or nil. If the block is not given, Ruby adds an implicit
  # lock of { |obj| obj } that will cause any? to return true if at
  # least one of the collection members is not false or nil.
  def my_any?
    result = false
    for element in self
      if (yield(element))
        result = true
      end
    end
    result
  end

  # Passes each element of the collection to the given block.
  # The method returns true if the block never returns true for all
  # elements. If the block is not given, none? will return true only
  # if none of the collection members is true.
  def my_none?
    result = true
    for element in self
      if (yield(element))
        result = false
      end
    end
    result
  end

  # Returns the number of items in enum through enumeration.
  # If an argument is given, the number of items in enum that are
  # equal to item are counted. If a block is given, it counts the
  # number of elements yielding a true value.
  def my_count
    counter = 0
    if(block_given?)
      for element in self
        if (yield(element))
          counter += 1
        end
      end
    else
      for element in self
        counter += 1
      end
    end
    counter
  end

  # Returns a new array with the results of running block once for
  # every element in enum.
  def my_map
    arr = []
    for element in self
      arr.push(yield(element))
    end
    arr
  end

  # Combines all elements of enum by applying a binary operation,
  # specified by a block or a symbol that names a method or operator.
  def my_inject(memo = nil)
    if(memo == nil)
      memo = self[0]
    end
    for element in self
      memo = yield(memo, element)
    end
  end

  # Multiplies all the elements of the array together
  def multiply_els(arr)
    return arr.my_inject {|pro, num| pro * num}
  end

end

arr = [11,54,4,82]
arr2 = ["phoenix", "turtle", "dragon", "tiger"]
puts "Testing my_each"
arr.my_each {|i| puts "Val: #{i}"}

puts ""

puts "Testing my_each_with_index"
arr.my_each_with_index { |i,j| puts "Val: #{i}  Index: #{j}"}

puts ""

puts "Testing my_select"
puts arr.my_select { |i| i < 30}

puts ""

puts "Testing my_all?"
puts arr.my_all? { |i| i < 30}

puts ""

puts "Testing my_any?"
puts arr.my_any? { |i| i < 30}

puts ""

puts "Testing my_none?"
puts arr2.my_none? { |i| i.length == 6}

puts ""

puts "Testing my_count"
puts arr2.my_count { |i| i.length >5}

puts ""

puts "Testing my_map"
puts arr.my_map { |i| i*i }      #=> [1, 4, 9, 16]

puts ""

puts "Testing my_inject"
puts multiply_els(arr)
