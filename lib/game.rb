require_relative 'words.rb'
require_relative 'diagram.rb'

class Game
  include Diagram

  attr_accessor :words, :crossed_letters, :user_guess_array, :chosen_word_array, :user_fails

  def initialize
    @words = Words.new
  end

  def game_setup
    self.user_fails = 0
    self.chosen_word_array = words.dictionary.sample.downcase.chars
    p chosen_word_array
    self.user_guess_array = Array.new(chosen_word_array.length, '_')
  end

  def guess_tray
    user_guess_array.reduce('') do |string, char|
      string = string + ' ' + char
      string.strip!
    end
  end

  def display
    puts diagram[user_fails]
    puts guess_tray
  end

  def game_command(input)
    case 
    when crossed_letters.any? { |letter| input.include?(letter)}
      puts "\"#{input.join.upcase}\" includes crossed out letters!"
      user_turn
    when input.length >= chosen_word_array.length
      guess_word(input[0...chosen_word_array.length])
    when ('a'..'z').include?(input.chr) && user_guess_array.any? { |letter| input.chr == letter}
      puts "You've already confirmed \"#{input.chr.upcase}\"!"
      user_turn
    when ('a'..'z').include?(input.chr)
      guess_letter(input.chr)
    else
      puts "Enter a letter."
      user_turn
    end
    #Write a function that takes the users input, and matches it
    #with cases(or commands), and runs other methods depending on
    #the input given
    #This method should be able to check if the input array's length is
    #the same as the chosen word's length, and if that's the case then
    #its the user attempting a guess
    #This method should be able to check if the user has entered an already
    #crossed out word, and prompt them to enter another word, running the user_turn
    #method
    #This method should prompt the user to enter one letter if they either either
    #no input, space, a number or any character that isnt a letter
  end

  def user_turn
    user_input = gets.chomp.downcase.chars
    game_command(user_input)
  end

  def begin_game
    until user_fails.eql?(6)
      user_turn
    end
  end

  def game_end

  end

  def play
    game_setup
    display
    begin_game
    game_end
  end
end

puts 'Game loading...'
game = Game.new
puts 'Game loaded'
game.play