require "yaml"

class Hangman
	attr_accessor :secret_word, :strike_count, :board, :guesses, :turns

	def initialize(filename)
		@save = "file.yaml"
		@turns = 6
		@secret_word = create_secret_word(filename)
		@board = create_board
		@strike_count = 0
		@guesses = []
	end

	def create_secret_word(filename)
		if File.file?(filename)
			words = []

			file = File.readlines(filename).each do |line|
				words << line  
			end
			
			# Select word between 5 and 12 characters long
			# Remove newline characters in each word
			word = ""
			while word.length < 5 || word.length > 12
				word = words[rand(0..words.size-1)]
				word = word[0..-3]
			end 
			return word.downcase
		else 
			puts "Error: File does not exist."
			return nil 
		end 
	end 

	def create_board 
		board = ""
		size = @secret_word.length

		size.times do 
			board += "_"
		end
		return board
	end 

	def greeting
		puts "Hangman\n\n"
		puts "A word between 5 and 12 characters has been chosen for you to guess."
		puts "Guess letters to reveal the secret word!\n\n"
	end 

	def display_game 
		puts "Board: #{@board}"
		puts "Guesses: #{@guesses}"
		puts "Incorrect guesses: #{@strike_count}"
		puts ""
	end 

	def get_input 
		input = ""
		loop do 
			print "Enter a letter: "
			input = gets.chomp.downcase

			if @guesses.include? input 
				puts "Letter already guessed!"
			else 
				break
			end 
		end 
		return input 
		puts ""
	end 

	def update_game(input)
		# Check if input is part of secret word
		# Else add to guesses and strike count
		if @secret_word.include? input 
			size = @secret_word.size 
			(0..size-1).each do |count|
				if @secret_word[count] == input 
					@board[count] = input
				end 
			end  
		else 
			@guesses << input
			@strike_count += 1
		end
	end 

	def check_game_over 
		if @secret_word == @board
			puts "You win! You guessed the secret word!"
			return true 
		elsif @strike_count == @turns
			puts "Game Over! You ran out of time!"
			puts "The secret word was #{@secret_word}!"
			return true
		else
			return false 
		end 
	end 

	def load_game 
		print "Would you like to load a save?(y/n):"
		input = gets.chomp.downcase

		if input == "y"
			if File.file?(@save)
				content = File.open(@save, "r") {|file| file.read}
				puts "Game loaded.\n\n"
				YAML.load(content).start_game
			else
				puts "Error. No save found!"
			end
		elsif input == "n" 
			# do nothing
		else 
			puts "Invalid input"
		end 
		puts ""
	end 

	def save_game 
		print "Would you like to save?(y/n):"
		input = gets.chomp.downcase 
		puts ""

		if input == "y"
			filename = @save
			File.open(filename, "w") do |file|
				file.puts YAML.dump(self)
				puts "Gave saved."
			end 
		elsif input == "n"
			# do nothing 
		else 
			puts "Invalid input"
		end 
	end 

	def start_game 
		greeting
		load_game 
		game_over = false 
		while !game_over 
			save_game 
			display_game
			input = get_input
			update_game(input) 
			game_over = check_game_over
		end 
	end 
end 

game = Hangman.new("5desk.txt")
game.start_game