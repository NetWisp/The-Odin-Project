# Project 2: Mastermind
# 
# If you've never played Mastermind, a game where you have to guess your opponent's secret code within a certain number of turns (like hangman with colored pegs), check it out on Wikipedia. Each turn you get some feedback about how good your guess was -- whether it was exactly correct or just the correct color but in the wrong space.
#
# Your Task
# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer's random code.
#
# Think about how you would set this problem up!
# Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!
# Now refactor your code to allow the human player to choose whether she wants to be the creator of the secret code or the guesser.
# Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).
# Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.

class Mastermind
	attr_accessor :turns, :colors, :secret_code, :board, :ai_guess
	
	def initialize(turns)
		@turns = turns
		@colors = create_colors
		@secret_code = []
		@board = [] 
		@ai_guess = []
	end 
	
	def create_colors
		@colors = ["red", "orange", "yellow", "blue", "green", "indigo", "violet"]
	end 
	
	def greeting 
		puts "Mastermind\n\n"
		print "Colors available:"
		@colors.each do |color|
			print "#{color} "
		end 
		puts ""
	end 
	
	def does_user_create_secret_code
		valid_input = false 
		while !valid_input
			print "Do you want to create the secret code? (y/n):"
			input = gets.chomp
			
			if input == "y"
				return true 
			elsif input == "n"
				return false 
			else 
				puts "Invalid input! Try again!"
			end 
		end 
	end 
	
	def comp_create_secret_code
		4.times do 
			@secret_code << @colors[rand(0..6)]
		end 
	end 
	
	def enter_colors
		guess = []
		valid_input= false 
		valid_count = 0
		
		while !valid_input
			print "Enter 4 colors: "
			guess = gets.chomp.split(" ")
		
			guess.each do |input_color|
				@colors.each do |color|
					if input_color == color
						valid_count += 1 
					end
				end 
			end
			if valid_count == 4
				return guess 
			else 
				puts "Invalid input entered. Try again!"
			end
		end 
	end 
	
	def display_board 
		puts "\nGame Board"
		@board.reverse_each do |guess|
			print "#{guess} " 
			puts ""
		end 
		puts ""
	end 
	
	def display_feedback(guess) 
		correct_colors = 0 
		correct_position = 0

		secret_code_hash = Hash.new(0)
		@secret_code.each do |color|
			secret_code_hash[color] += 1
		end 
		
		guess.each do |color|
			if secret_code_hash.key?(color)
				if secret_code_hash[color] != 0 
					correct_colors += 1 
					secret_code_hash[color] -= 1
				end
			end
		end 
		
		(0..3).each do |i|
			if guess[i] == @secret_code[i]
				correct_position += 1 
			end 
		end 
		
		puts "Number of correct colors: #{correct_colors}"
		puts "Number of correct positions: #{correct_position}"
		puts "\n\n"
		
	end 
	
	def check_game_over(guess, user_create_secret_code)
		if guess == @secret_code
			if user_create_secret_code
				puts "Game Over! You lose! The AI figured out the secret code!"
			else 
				puts "Congratulations! You win!"
			end 
			return true 
		elsif @board.size == @turns 
			if user_create_secret_code
				puts "Congratulations! You win! The AI couldn't figure out the secret code!"
			else 
				puts "Game Over! You lose!"
				puts "The secret code was #{@secret_code}"
			end 
			return true 
		else 
			return false 
		end
	end 
	
	def set_ai_guess
		if @ai_guess == []
			4.times do 
				@ai_guess << @colors[rand(0..6)]
			end 
		else 
			(0..3).each do |i|
				if @ai_guess[i] != @secret_code[i]
					different_color = false
					
					while !different_color 
						new_color = @colors[rand(0..6)]
						if @ai_guess[i] != new_color
							@ai_guess[i] = new_color
							different_color = true 
						end 
					end 
				end 
			end 
		end 
	end 
	
	def start_game 
		greeting
		user_create_secret_code = does_user_create_secret_code
		puts ""
		
		if user_create_secret_code
			puts "Enter the secret code!\n\n"
			@secret_code = enter_colors
			game_over = false 
			
			while !game_over 
				set_ai_guess
				guess = @ai_guess
				@board << guess.to_s
				puts "Secret Code: #{@secret_code}"
				display_board
				display_feedback(guess)
				game_over = check_game_over(guess,user_create_secret_code)
			end 
		else 
			puts "Guess the secret code!\n\n"
			comp_create_secret_code
			game_over = false 
			
			while !game_over 
				guess = enter_colors
				@board << guess
				display_board
				display_feedback(guess)
				game_over = check_game_over(guess,user_create_secret_code)
			end 
		end 
	end 
end 

game = Mastermind.new(12) 
game.start_game