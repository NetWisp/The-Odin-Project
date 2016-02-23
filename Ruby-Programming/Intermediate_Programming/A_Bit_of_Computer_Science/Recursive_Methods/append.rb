def append(ary, n)
  if n == 0
    return ary << 0
  else
    ary << n
    append(ary, n-1)
  end
end

puts append([], 5)
