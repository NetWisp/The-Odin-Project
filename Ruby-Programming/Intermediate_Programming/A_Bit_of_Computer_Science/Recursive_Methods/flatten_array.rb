def flatten(cur_ary, flat_ary =[])
  ary.each do |elem|
    if elem.is_a? (Array)
      flatten(ary, flat_ary)
    else
      flat_ary << elem
    end
  end
  flat_ary
end

def check_array(ary)
  ary.each do |elem|
    if elem.is_a? (Array)
      puts "Beginning of inner array"
      puts elem
      puts "End of inner array"
    end
  end
  puts ""
end

puts "Initial array"
ary = [[1, [8, 9]], [3, 4]]
check_array(ary)
puts "Flattening array"
ary.flatten
check_array(ary)
