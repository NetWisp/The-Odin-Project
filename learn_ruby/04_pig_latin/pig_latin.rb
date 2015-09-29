def translate(phrase)
	words = phrase.split
	len = words.length
	temp = ""
	translation = ""
	i = 0

	while i < len
		# initial word added to string
		if i == 0
			temp = pig(words[i])
			translation = temp
		else
			temp = pig(words[i])
			translation = translation + " " + temp
		end
		i += 1
	end

	return translation
end

def pig(word)
	vowels = ['a', 'e', 'i' , 'o', 'u']
	temp = ""
	
	# Rule 1: If a word begins with a vowel sound, add an "ay" sound to the end of the word.
	if vowels.include?(word[0])
		temp = word + "ay"

	# Rule 2: If a word begins with a consonant sound, move it to the end of the word, 
	# and then add an "ay" sound to the end of the word.
	# Note: search until first vowel, with certain exceptions
	else
		found = false
		i = 1

		while found == false
			if vowels.include?(word[i])
				found = true

				# if previous letter is q, current letter is u
				if  (word[i-1] == "q")
					found = false
					i += 1
				end
			else
				i += 1
			end
		end

		temp = word[i..-1] + word[0..i-1] + "ay"
	end

	return temp
end