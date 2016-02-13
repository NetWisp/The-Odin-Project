puts "Caesar Cipher"
puts "Info: A caesar cipher that takes in a string and the shift factor and then outputs the modified string"
puts ""

# Takes a string and shift factor
def caesar_cipher(phrase = "", shift = 0)
  cipher = ""

# traverse through each character of phrase
  phrase.split("").each do |i|
    # check if the current character is part of alphabet
    # if it is, increase i by shift amount
    if (i =~ /[[:alpha:]]/)
      counter = shift
      while (counter != 0)
        if (i == "z")
          i = "a"
          counter = counter - 1
        else
          i = i.ord.next.chr
          counter = counter - 1
        end
      end
      cipher = cipher + i
    end
  end

  return cipher
end

print "Enter phrase: "
phrase = gets.chomp

print "Enter shift: "
str_shift = gets.chomp
shift = str_shift.to_i
puts ""
puts caesar_cipher(phrase, shift)
