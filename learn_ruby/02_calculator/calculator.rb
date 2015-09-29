def add(a,b)
	return a + b
end

def subtract(a,b)
	return a - b
end

def sum(array)
	sum = 0
	array.each do |item|
		sum += item
	end
	return sum
end

def multiply(array)
	mult = 1
	array.each do |item|
		mult *= item
	end
	return mult 
end

def power(a,b)
	return a ** b
end

def factorial(num)
	if num == 0
    	num = 1
    	return num
    elsif num == 1
    	return num    		
 	else
 		num * factorial(num-1)
 	end
end