# Divide the unsorted list into n sublists, each containing 1 element
# (a list of 1 element is considered sorted).
# Repeatedly merge sublists to produce new sorted sublists
# until there is only 1 sublist remaining. This will be the sorted list.
def merge_sort(arr)
  if arr.size == 1
    return arr
  end

  mid = arr.size / 2
  left_arr = merge_sort(arr[0..mid-1])
  right_arr = merge_sort(arr[mid..-1])

  merge(left_arr, right_arr)
end

def merge(left_arr, right_arr)
  arr = []

  while left_arr.size > 0 && right_arr.size > 0
    if left_arr[0] < right_arr[0]
      arr << left_arr.shift
    else
      arr << right_arr.shift
    end
  end

  if left_arr.empty?
    arr += right_arr
  else
    arr += left_arr
  end

  arr
end

def display_array(arr)
  arr.each do |elem|
    print "#{elem} "
  end
  puts ""
end

arr = [38, 27, 43, 3, 9, 82, 10]

puts "Unsorted array: "
display_array(arr)

puts "Sorting array..."
arr = merge_sort(arr)

puts "Sorted array: "
display_array(arr)
