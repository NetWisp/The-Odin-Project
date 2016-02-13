def bubble_sort(arr)
  arr_size = arr.size
  if(arr_size == 1)
    puts "Array has size of 1. Already sorted."
  else
    sorted = false
    while (!sorted)
      sorted = true   # Assume true until proven false
      left = 0
      right = 1
      while(right < arr_size)
        if (arr[right] < arr[left])   # Swap numbers
          temp = arr[right]
          arr[right] = arr[left]
          arr[left] = temp
          sorted = false
        end
        left += 1
        right += 1
      end
    end
  end
end

arr = [4, 3, 78, 2, 0, 2]
bubble_sort(arr)
arr.each do |x|
  print "#{x}  "
end

puts ""

def bubble_sort_by(arr)
  arr_size = arr.size
  if(arr_size == 1)
    puts "Array has size of 1. Already sorted."
  else
    sorted = false
    while (!sorted)
      sorted = true   # Assume true until proven false
      left = 0
      right = 1
      while(right < arr_size)
        if (yield(arr[left], arr[right]) > 0)  # Left is bigger than right
           temp = arr[right]
          arr[right] = arr[left]
          arr[left] = temp
          sorted = false
        end
        left += 1
        right += 1
      end
    end
  end
end

arr2 = ["hi","hello","hey"]
bubble_sort_by(arr2) do |left,right|
  left.length - right.length
end
arr2.each do |x|
  print "#{x}  "
end
