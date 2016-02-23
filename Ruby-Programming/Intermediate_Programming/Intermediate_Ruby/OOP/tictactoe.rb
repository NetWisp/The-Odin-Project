# Tic Tac Toe Game
# Tic-tac-toe (also known as Noughts and crosses or Xs and Os) is a
# paper-and-pencil game for two players, X and O, who take turns marking t
# he spaces in a 3×3 grid.

# Check conditions for game over
# The player who succeeds in placing three of their marks in a
# horizontal, vertical, or diagonal row wins the game.
# Players soon discover that best play from both parties leads to a draw.
def check_game_over(board)
  # Check rows
  if((board[0][0] == board[0][1]) && (board[0][1] == board[0][2]) && board[0][0] != " ")
    return true
  elsif((board[1][0] == board[1][1]) && (board[1][1] == board[1][2]) && board[1][0] != " ")
    return true
  elsif((board[2][0] == board[2][1]) && (board[2][1] == board[2][2]) && board[2][0] != " ")
    return true
  end

  # Check cols
  if((board[0][0] == board[1][0]) && (board[1][0] == board[2][0]) && board[0][0] != " ")
    return true
  elsif((board[0][1] == board[1][1]) && (board[1][1] == board[2][1]) && board[0][1] != " ")
    return true
  elsif((board[0][2] == board[1][2]) && (board[1][2] == board[2][2]) && board[0][2] != " ")
    return true
  end

  # Check diags
  if((board[0][0] == board[1][1]) && (board[1][1] == board[2][2]) && board[0][0] != " ")
    return true
  elsif((board[0][2] == board[1][1]) && (board[1][1] == board[2][0]) && board[1][0] != " ")
    return true
  end

  # Check tie
  tie = true
  board.each do |x,y,z|
    if(x == " " || y == " " || z == " ")
      tie = false
    end
  end
  return tie
end

# Set player move
# Check to see if the current space is occupied, if not
# place the move
def set_move(player_move, symbol, game_board)
  # will set player move here
  case player_move
  when "1"
    if(game_board[0][0] == " ")
      game_board[0][0] = symbol
    end
  when "2"
    if(game_board[0][1] == " ")
      game_board[0][1] = symbol
    end
  when "3"
    if(game_board[0][2] == " ")
      game_board[0][2] = symbol
    end
  when "4"
    if(game_board[1][0] == " ")
      game_board[1][0] = symbol
    end
  when "5"
    if(game_board[1][1] == " ")
      game_board[1][1] = symbol
    end
  when "6"
    if(game_board[1][2] == " ")
      game_board[1][2] = symbol
    end
  when "7"
    if(game_board[2][0] == " ")
      game_board[2][0] = symbol
    end
  when "8"
    if(game_board[2][1] == " ")
      game_board[2][1] = symbol
    end
  when "9"
    if(game_board[2][2] == " ")
      game_board[2][2] = symbol
    end
  else
  end
end

# Set up the initial board to play
def create_game_board(game_board)
  board = []
  row1 = ["1", "2", "3"]
  row2 = ["4", "5", "6"]
  row3 = ["7", "8", "9"]
  board << row1
  board << row2
  board << row3
  return board
end

# Display board to users
def display_board(board)
  board.each do |x,y,z|
    print x + " " + y + " " + z
    puts ""
  end
end

# Main code to run game
puts "Tic Tac Toe Game"
puts "Player 1 - X"
puts "Player 2 - O"
puts ""

game_board = create_game_board(game_board)
player_1_move = true
player_2_move = false
board = create_game_board(board)
sample = create_game_board(sample)
game_over = false

# Clear initial board for game
board[0][0] = " "
board[0][1] = " "
board[0][2] = " "
board[1][0] = " "
board[1][1] = " "
board[1][2] = " "
board[2][0] = " "
board[2][1] = " "
board[2][2] = " "

puts "Moves follow this board:"
display_board(sample)
puts ""
puts "Current board:"
  display_board(board)
  puts ""

# Begin loop of game until over
while(!game_over) do
  if(player_1_move)
    puts "Player 1 enter a move: "
    player_1_move = gets.chomp
    set_move(player_1_move, "X", board)
    player_1_move = false
    player_2_move = true
    puts ""
  elsif(player_2_move)
    puts "Player 2 enter a move: "
    player_2_move = gets.chomp
    set_move(player_2_move, "O", board)
    player_1_move = true
    player_2_move = false
    puts ""
  else
    # should not hit here
  end
  puts "Current board:"
  display_board(board)
  puts ""
  game_over = check_game_over(board)
end

puts "Game Over!"
