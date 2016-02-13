# Mastermind
# Mastermind or Master Mind is a code-breaking game for two players.
# The modern game with pegs was invented in 1970 by Mordecai Meirowitz,
#  Israeli postmaster and telecommunications expert.[1][2] It resembles
#  an earlier pencil and paper game called Bulls and Cows that may date
#  back a century or more.

def generate_code(code)
  code.map! do |element|
    element = $COLORS[rand(0..5)]
  end
  return code
end

def generate_board(board)
  for turn in 1..$NUM_TURNS
    board << Array.new(4, "*")
  end
  return board
end

def display_board(board)
  board.each do |w,x,y,z|
    puts w + " " + x + " " + y + " " + z
  end
  puts ""
end

def update_board(board, guess,turn)
  for i in 0..3
    board[$NUM_TURNS -turn][i] = guess[i]
  end
end

# Give 4 hints to player for each color
def check_code(guess, code)
  game_over = false
  correct_count = 0

  for i in 0..3
    message = "One wrong color"

    if((guess[i] == code[0]) || (guess[i] == code[1]) ||
      (guess[i] == code[2]) || (guess[i] == code[3]))
      message = "One correct color in wrong position"
    end

    if(guess[i] == code[i])
      message = "One correct color in correct position"
      correct_count += 1
    end

    puts message
  end

  puts ""

  if(correct_count == 4)
    puts "Congratulations you win!"
    game_over = true
  end

  return game_over
end

def set_guess_code(guess, code)
  for i in 0..3
    if(guess[i] != code[i])
      guess[i] = $COLORS[rand(0..5)]
    end
  end
  return guess
end

$NUM_TURNS = 16
$COLORS = ["red", "orange", "yellow", "blue", "indigo", "violet"]
game_over = false
code = ["","","",""]
guess_code = ["","","",""]
board = []

# Begin game
# Ask user to create or guess secret code

puts "Mastermind"
puts "Enter 1 to create code"
puts "Enter 2 to guess code"
print "Enter choice: "
play_mode = gets.chomp
puts ""

case play_mode
when "1"
  #do something
  puts "Colors: red, orange, yellow, green, blue, indigo, violet"
  puts "Enter 4 colors to be the code"
  colors = gets.chomp
  code = colors.split(" ")
   board = generate_board(board)

  if(!game_over)
    for turn in 1..$NUM_TURNS
      puts "TURN: " + turn.to_s
      display_board(board)
      guess_code = set_guess_code(guess_code, code)
      update_board(board, guess_code, turn)
      game_over = check_code(guess_code, code)
    end
    puts "The code was:"
    code.each do |item|
      print item + " "
      puts ""
    end
    puts "Game Over!"
  end

when "2"
  generate_code(code)
  board = generate_board(board)

  if(!game_over)
    for turn in 1..$NUM_TURNS
      puts "TURN: " + turn.to_s
      display_board(board)
      puts "Enter guess (red, orange, yellow, green, blue, indigo, or violet):"
      guess = gets.chomp
      guess_code = guess.split(" ")
      update_board(board, guess_code, turn)
      game_over = check_code(guess_code, code)
    end
    puts "The code was:"
    code.each do |item|
      print item + " "
      puts ""
    end
    puts "Game Over!"
  end

else
  puts "Incorrect input!"
end
