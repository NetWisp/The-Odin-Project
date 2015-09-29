class Book
	@title

	def title=(new_title)
		@title = new_title
		@title = cap(@title)
	end

	# title variable
	def title
		@title
	end
end

def cap(phrase)
	littleWords = ['a', 'an', 'and', 'for', 'the', 'in', 'of', 'or', 'over']
	phrase = phrase.gsub(/\w+/) {|match| littleWords.include?(match)? match : match.capitalize}
	return phrase.slice(0,1).capitalize + phrase.slice(1..-1)
end