=begin
Project 3: Substrings

Your Task
Implement a method #substrings that takes a word as the first argument and then an array of valid substrings (your dictionary) as the second argument. It should return a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.

    > dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
    => ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

    > substrings("below", dictionary)
    => {"below"=>1, "low"=>1}
Next, make sure your method can handle multiple words:

    > substrings("Howdy partner, sit down! How's it going?", dictionary)
    => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
Quick Tips:

Recall how to turn strings into arrays and arrays into strings.
=end

def substrings(text, dictionary)
	word_list = Hash.new(0)
	text_array = text.downcase.split(" ")
	
	text_array.each do |text|
		dictionary.each do |word|
			if text.include? word
				word_list[word] += 1 
			end
		end
	end
	word_list
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

print "Enter text: "
text = gets.chomp 
puts "\nFinding substrings...\n\n"
word_list = substrings(text, dictionary)
puts word_list