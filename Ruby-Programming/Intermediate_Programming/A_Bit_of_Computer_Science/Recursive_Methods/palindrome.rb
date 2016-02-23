def palindrome(word)
  if word.length == 1 || word.length == 0
    true
  else
    if word[0] == word[-1]
      palindrome(word[1..-2])
    else
      false
    end
  end
end

word = "racecar"
puts palindrome(word)

