=begin
Project 1: Bubble Sort

Sorting algorithms are some of the earliest that you typically get exposed to in Computer Science. It may not be immediately obvious how important they are, but it shouldn't be hard to think of some examples where your computer needs to sort some massive datasets during everyday operations.

One of the simpler (but more processor-intensive) ways of sorting a group of items in an array is bubble sort, where each element is compared to the one next to it and they are swapped if the one on the left is larger than the one on the right. This continues until the array is eventually sorted.

Check out this video from Harvard's CS50x on Bubble Sort.

There's also an entry on Bubble Sort on Wikipedia that's worth taking a look at.

Bubble Sort

Your Task
Build a method #bubble_sort that takes an array and returns a sorted array. It must use the bubble sort methodology (using #sort would be pretty pointless, wouldn't it?).

    > bubble_sort([4,3,78,2,0,2])
    => [0,2,2,3,4,78]
Now create a similar method called #bubble_sort_by which sorts an array but accepts a block. The block should take two arguments which represent the two elements currently being compared. Expect that the block's return will be similar to the spaceship operator you learned about before -- if the result of the block is negative, the element on the left is "smaller" than the element on the right. 0 means they are equal. A positive result means the left element is greater. Use this to sort your array.
=end 

def bubble_sort(arr) 
	size = arr.size 
	
	case size 
	when 0
		return arr
	when 1 
		return arr 
	when 2 
		if arr[0] > arr[1]
			arr[0], arr[1] = arr[1], arr[0]
		end 
		return arr 
	else 
		sorted = false 
		
		while !sorted 
			sorted = true 
			arr[0..-2].each_with_index do |val, i|
				left = arr[i] 
				right = arr[i+1]
				
				if left > right 
					arr[i],arr[i+1] = arr[i+1],arr[i]
					sorted = false 
				end 
			end 
		end 
		return arr 
	end 
end 

def bubble_sort_by(arr) 
	size = arr.size 
	
	case size 
	when 0
		return arr
	when 1 
		return arr 
	when 2 
		if arr[0] > arr[1]
			arr[0], arr[1] = arr[1], arr[0]
		end 
		return arr 
	else 
		sorted = false 
		
		while !sorted 
			sorted = true 
			arr[0..-2].each_with_index do |val, i|
				left = arr[i] 
				right = arr[i+1]

				if yield(left, right) > 0
					arr[i],arr[i+1] = arr[i+1],arr[i]
					sorted = false 
				end 
			end 
		end 
		return arr 
	end
end 

def create_array
	arr = []
	input = 0 
	
	puts "Create array (Enter q to quit): "
	while (input != "q" && input != "Q")
		input = gets.chomp 
		arr << input.to_i unless (input == "q" || input == "Q")
	end
	arr 
end

def create_array_2
	arr = []
	input = 0 
	
	puts "Create array (Enter q to quit): "
	while (input != "q" && input != "Q")
		input = gets.chomp 
		arr << input unless (input == "q" || input == "Q")
	end
	arr 
end

=begin
arr = create_array
puts "\nApplying bubble sort...\n\n"
sorted_arr = bubble_sort(arr)
puts sorted_arr

puts "\n\n"
=end
arr = create_array_2
puts "\nApplying bubble sort by...\n\n"
sorted_arr_2 = bubble_sort_by(arr) do |left, right| 
	left.length - right.length
end
puts sorted_arr_2
