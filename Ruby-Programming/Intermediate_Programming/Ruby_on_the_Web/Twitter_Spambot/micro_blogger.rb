require "jumpstart_auth"
require "bitly"
require "klout"

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
    Bitly.use_api_version_3
    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
  end

  # If the message to tweet is less than or equal to 140 characters long, tweet it.
  # Otherwise, print out a warning message and do not post the tweet.
  def tweet(message)
    if message.length <= 140
      client.update(message)
    else
      puts "Your message exceeds 140 characters and cannot be tweeted"
    end
  end

  # Let’s add a way to verify that the target is following you before
  # sending the message. In pseudo-code, it’d go something like this:
  # Find the list of my followers
  # If the target is in this list, send the DM
  # Otherwise, print an error message
  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message

    screen_names = followers_list

    # If the target username is in the screen_names list (use Array#include? method), then send the DM
    # Otherwise, print out an error saying that you can only DM people who follow you
    if screen_names.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "You can only directly message people who follow you!"
    end
  end

  def followers_list
    screen_names = Array.new
    @client.followers.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    return screen_names
  end

  def spam_my_followers(message)
    followers = followers_list
    followers.each do |follower|
      puts follower
      dm(follower, message)
    end
  end

  def everyones_last_tweet
    friends = @client.friends
    friends = friends.sort_by do |friend|
      @client.user(friend).screen_name.downcase
    end

    friends.each do |friend|
      friend_data = @client.user(friend)
      last_message = friend_data.status.text
      name = friend_data.screen_name
      time = friend_data.status.created_at
      time.strftime("%A, %b %d")

      puts "#{name}'s last tweet at #{time}:"
      puts last_message
      puts ""  # Just print a blank line to separate people
    end
  end

  def shorten(original_url)
    puts "Shortening this URL: #{original_url}"
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    url = bitly.shorten(original_url).short_url
    puts "Shorten URL: #{url}"
    return url
  end

  def klout_score
    friends = @client.friends.collect{|f| @client.user(f).screen_name}
    friends.each do |friend|
      identity = Klout::Identity.find_by_screen_name(friend)
      user = Klout::User.new(identity.id)
      user.score.score
      puts "Klout score for #{friend} is #{user.score.score}"
      puts "" # Print a blank line to separate each friend
    end
  end

  # Run this in cmd: set SSL_CERT_FILE=C:\RailsInstaller\cacert.pem
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "Enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]

      case command
      when "t" then tweet(parts[1..-1].join(" "))
      when "dm" then dm(parts[1], parts[2..-1].join(" "))
      when "spam" then spam_my_followers(parts[1..-1].join(" "))
      when "elt" then everyones_last_tweet
      when "s" then shorten(parts[1..-1].join(" "))
      when "turl" then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
      when "k" then klout_score
      when "q" then puts "Goodbye!"
      else
        puts "Sorry, I don't know how to #{command}"
      end
    end
  end

  blogger = MicroBlogger.new
  blogger.run
end
