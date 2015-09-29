def echo(phrase)
	return phrase
end

def shout(phrase)
	return phrase.upcase
end

def repeat(phrase, count=1)
	i = 0
	echo = phrase

	if count == 1
		return phrase + " " + phrase
	end

	while i < count-1
		echo = echo + " " + phrase
		i += 1
	end


	return echo
end 

def start_of_word(text,num)
	if num == 1
		return text[0]
	else
		return text[0..(num - 1)]
	end
end

def first_word(phrase)
	words = phrase.split(' ')
	return words[0]
end

def titleize(phrase)
	littleWords = ['a', 'an', 'and', 'for', 'the', 'of', 'or', 'over']
	phrase = phrase.gsub(/\w+/) {|match| littleWords.include?(match)? match : match.capitalize}
	return phrase.slice(0,1).capitalize + phrase.slice(1..-1)
end
