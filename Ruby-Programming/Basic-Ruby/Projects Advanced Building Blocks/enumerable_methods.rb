=begin 
Project 2: Enumerable Methods

You learned about the Enumerable module that gets mixed in to the Array and Hash classes (among others) and provides you with lots of handy iterator methods. To prove that there's no magic to it, you're going to rebuild those methods.

Your Task
Create a script file to house your methods and run it in IRB to test them later.
Add your new methods onto the existing Enumerable module. Ruby makes this easy for you because any class or module can be added to without trouble ... just do something like:

    module Enumerable
      def my_each
        # your code here
      end
    end
Create #my_each, a method that is identical to #each but (obviously) does not use #each. You'll need to remember the yield statement. Make sure it returns the same thing as #each as well.

Create #my_each_with_index in the same way.

Create #my_select in the same way, though you may use #my_each in your definition (but not #each).

Create #my_all? (continue as above)

Create #my_any?

Create #my_none?

Create #my_count

Create #my_map

Create #my_inject

Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40

Modify your #my_map method to take a proc instead.

Modify your #my_map method to take either a proc or a block. It won't be necessary to apply both a proc and a block in the same #my_map call since you could get the same effect by chaining together one #my_map call with the block and one with the proc. This approach is also clearer, since the user doesn't have to remember whether the proc or block will be run first. So if both a proc and a block are given, only execute the proc.

Quick Tips:

Remember yield and the #call method.
=end 


module Enumerable 
	def my_each 
		if block_given?
			for i in 0..(self.length - 1) 
				yield self[i]
			end
		end 
	end
	
	def my_each_with_index 
		if block_given? 
			for i in 0..(self.length - 1) 
				yield(self[i],i)
			end
		end
	end
	
	def my_select 
		if block_given? 
			arr = []
			self.my_each do |i|
				arr << i if yield(i)
			end
			arr 
		end
	end
	
	def my_all 
		if block_given? 
			self.my_each do |i|
				return false unless yield(i)
			end
		end 
	end 
	
	def my_any
		if block_given? 
			self.my_each do |i|
				return true if yield(i)
			end
		end 	
	end 
	
	def my_none 
		if block_given? 
			none = true 
			self.my_each do |i| 
				if yield(i)
					none = false 
				end
			end 
			none 
		end 	
	end 
	
	def my_count(num=nil) 
		counter = 0 
		if block_given?
			self.my_each do |i|
				counter += 1 if yield(i)
			end 
		elsif num != nil
			self.my_each do |i|
				counter += 1 if i == num
			end 
		else
			counter = self.size 
		end
		counter 
	end 
	
	def my_map(param=0)
		array = self.dup
		if param.instance_of? Proc
			array.my_each_with_index do |item, index|
				array[index] = param.call(item)
		 	end
		 	if block_given?
		 		array.my_each_with_index do |item, index|
		 			array[index] = yield(item)
		 		end
		 	end
		array
		else
			"#<Enumerator: #{self}:my_map>"
		end
	end
	
	def my_inject(init=0)
		total = init 
		self.my_each do |num|
			total = yield(total, num)
		end
		total 
	end
	
	def multiply_els
		 self.my_inject(1) { |result, element| result * element }
	end 
end

arr = [1,2,3,4,5,6,7,8,9,10]

puts "Testing my_each...\n\n"
arr.my_each do |i| 
	puts i 
end 

puts "\nTesting my_each_with_index...\n"
arr.my_each_with_index do |i,j| 
	puts "#{i} : #{j}"
end 

puts "\n\nTesting my_select...\n"
puts arr.my_select {|num| num.even?}

puts "\n\nTesting my_all...\n"
puts arr.my_all {|num| num > 4}

puts "\n\nTesting my_any...\n"
puts arr.my_any {|num| num > 4}

puts "\n\nTesting my_none...\n"
puts arr.my_none {|num| num > 100}

puts "\n\nTesting my_count...\n"
puts arr.my_count
puts arr.my_count(2) 
puts arr.my_count {|num| num > 4}

puts "\n\nTesting my_map...\n"
puts arr.my_map {|num| num*num}

puts "\n\nTesting my_inject...\n"
puts arr.my_inject(1) {|product,num| product*num}

puts "\n\nTesting multiply_els...\n"
puts [1,2,3].multiply_els

puts "\n\nTesting my_map...\n"
map_proc = Proc.new { |num| num * 3 }
puts [1,2,3].my_map(&map_proc)