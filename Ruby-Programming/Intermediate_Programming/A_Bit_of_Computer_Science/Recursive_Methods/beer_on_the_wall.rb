def beer_on_the_wall(n)
  if n == 0
    puts "no more bottles of beer on the wall"
  else
    puts "#{n} bottles of beer on the wall"
    beer_on_the_wall(n-1)
  end
end

beer_on_the_wall(5)
