
# Project 1: Tic Tac Toe
# 
# Remember Tic Tac Toe? See Wikipedia if you can't remember the rules, or if you haven't ever played. It involves a couple of players, a simple board, checking for victory in a game loop... all the conditions that make it a fun little problem to solve using our newfound OOP sea legs. Let's build it!
#
# Your Task:
# Build a tic-tac-toe game on the command line where two human players can play against each other and the board is displayed in between turns.
#
# Think about how you would set up the different elements within the game... What should be a class? Instance variable? Method? A few minutes of thought can save you from wasting an hour of coding.
# Build your game, taking care to not share information between classes any more than you have to.

class Player
	attr_accessor :name, :symbol, :move
	
	def initialize(name, symbol, move)
		@name = name
		@symbol = symbol
		@move = move
	end
end

class TicTacToe
	def initialize
		@player_1 = Player.new(1, "X", false)
		@player_2 = Player.new(2, "O", false)
		@board = new_board
	end
	
	def new_board
		@board = [[],[],[]]
		@board.each do |index|
			3.times do 
				index << " "
			end 
		end 
	end
	
	def display_board(board)
		board.each do |index|
			print "#{index}\n"
		end 
		puts ""
	end
	
	def update_board(player, move)
		valid_move = false 
		
		case move 
		when "1"
			if @board[0][0] == " "
				@board[0][0] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "2"
			if @board[0][1] == " "
				@board[0][1] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "3"
			if @board[0][2] == " "
				@board[0][2] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "4"
			if @board[1][0] == " "
				@board[1][0] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "5"
			if @board[1][1] == " "
				@board[1][1] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "6"
			if @board[1][2] == " "
				@board[1][2] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "7"
			if @board[2][0] == " "
				@board[2][0] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "8"
			if @board[2][1] == " "
				@board[2][1] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		when "9"
			if @board[2][2] == " "
				@board[2][2] = player.symbol 
				valid_move = true 
			else 
				puts "Invalid move entered!"
			end 
		else
			puts "Invalid move entered!"
		end 
		
		return valid_move
	end 
	
	def make_move
		valid_move = false 
		if @player_1.move
			while !valid_move
				print "Player #{@player_1.name} move:"
				move = gets.chomp 
				valid_move = update_board(@player_1, move)
			end 
			@player_1.move = false 
			@player_2.move = true 
		else
			while !valid_move
				print "Player #{@player_2.name} move:"
				move = gets.chomp 
				valid_move = update_board(@player_2, move)
			end 
			@player_1.move = true  
			@player_2.move = false 
		end 
	end
	
	def greet 
		puts "Tic Tac Toe"
		puts "Player 1 vs Player 2\n\n"
		
		counter = 1  
		temp_board = [[],[],[]]
		temp_board.each do |index|
			3.times do 
				index << counter 
				counter += 1 
			end 
		end 
		display_board(temp_board)
		
		puts "The board is set up as above. Enter your moves with the number that corresponds to the position you want"
	end 
	
	def check_game_status 
		status = false 
		
		if @board[0][0] != " " && @board[0][0] == @board[0][1] && @board[0][1] == @board[0][2]
			if @board[0][0] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[1][0] != " " && @board[1][0] == @board[1][1] && @board[1][1] == @board[1][2] 
			if @board[1][0] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[2][0] != " " && @board[2][0] == @board[2][1] && @board[2][1] == @board[2][2] 
			if @board[2][0] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[0][0] != " " && @board[0][0] == @board[1][0] && @board[1][0] == @board[2][0]
			if @board[0][0] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[0][1] != " " && @board[0][1] == @board[1][1] && @board[1][1] == @board[2][1]
			if @board[0][1] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[0][2] != " " && @board[0][2] == @board[1][2] && @board[1][2] == @board[2][2]
			if @board[0][2] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[0][0] != " " && @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
			if @board[0][0] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		elsif @board[0][2] != " " && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
			if @board[0][2] == "X"
				puts "Player 1 Wins!"
			else 
				puts "Player 2 Wins!"
			end 
			status = true 
		else
			# do nothing 
		end 
		
		return status 
	end 
	
	def start_game
		greet 
		@player_1.move = true 
		game_over = false 
		
		while !game_over 
			display_board(@board)
			make_move
			game_over = check_game_status
		end 
	end 
end 

game = TicTacToe.new 
game.start_game

