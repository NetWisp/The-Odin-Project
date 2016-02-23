require "yaml"

class Hangman
  def set_secret_word(file)
    word_file = File.open(file, "r")
    word_array = []
    word_counter = 0
    word = ""

    # Initialize array of words to randomly select a word from
    word_file.each_line do |word|
      word = word[0..word.length-2]   # Delete newline char at end of word
      word_array << word
      word_counter += 1
    end

    # Randomy select a word in the array and check that it is
    # between 5 and 12 characters long for the secret word
    loop do
      word = word_array[rand(0..word_counter-1)]
      break if (word.length >= 5) && (word.length <= 12)
    end

    word
  end

  def init_player_word(secret_word)
    word = ""

    secret_word.length.times do
      word << "_"
    end
    word
  end

  def game_over(secret_word, display_word, wrong_guesses)
    if secret_word == display_word
      puts "Congratulations! You guessed the right word!"
      true
    elsif wrong_guesses == @MAX_WRONG_GUESSES
      puts "Game Over! The man got hanged!"
      puts "The word was #{secret_word}"
      true
    else
      false
    end
  end

  def display_game(display_word, letters_used,wrong_guesses)
    puts "The current word: #{display_word}"

    print "Letters used: "
    letters_used.each do |letter|
      print "#{letter} "
    end
    puts ""

    puts "Number of guesses: #{wrong_guesses}/#{@MAX_WRONG_GUESSES}"
    puts ""
  end

  # Check letter against secret word and update player word accordingly
  def update_player_word(input, secret_word, player_word)
    return_word = player_word
    length = secret_word.length
    counter = 0

    until counter == length
      if secret_word[counter] == input
        return_word[counter] = input
      end

      counter += 1
    end

    return_word
  end

  def save_game
    File.open(@filename, "w") do |file|
      file.puts YAML.dump(self)
    end
  end

  def load_game
    if File.exists? @filename
      puts "Save game loaded!"
      puts ""
      YAML.load_file(@filename).play_game
    else
      puts "No save file found!"
      puts ""
    end
  end

  def init_game
    @WORD_LIST = "5desk.txt"
    @MAX_WRONG_GUESSES = 6

    @filename = "hangman_save_data.yaml"
    @secret_word = set_secret_word(@WORD_LIST)
    @player_word = init_player_word(@secret_word)
    @letters_used = []
    @wrong_guesses = 0
    @input = ""

    puts "Hangman"
    puts "Guess the word before the man gets hanged!"
    puts ""
    print "Load save file? (y/n): "
    load = gets.chomp
    load.downcase!
    if load == "y"
      load_game
      puts "Game loaded!"
    end
    puts ""
  end

  def play_game
    init_game unless @letters_used != nil
    quit = false
    while (!quit) do
      # Check for valid input, uppercase letter should be downcased

      print "Enter a letter or type save to save your game: "
      loop do
        @input = gets.chomp
        break if @input =~ /[A-Za-z]/
      end
      @input.downcase!
      if @input == "save"
        save_game
        puts "Game saved!"
        puts ""
      end

      temp = @player_word.dup  # Use String#dup so it doesn''t point to same obj
      @player_word = update_player_word(@input, @secret_word, @player_word)

      if temp == @player_word
        @wrong_guesses += 1 unless @input == "save"
      end
      @letters_used << @input unless @input == "save"

      display_game(@player_word, @letters_used, @wrong_guesses)
      quit = game_over(@secret_word, @player_word, @wrong_guesses)
    end
  end
end

hangman_game = Hangman.new
hangman_game.play_game

