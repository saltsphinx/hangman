require_relative 'words.rb'
require_relative 'diagram.rb'
require 'pry-byebug'

class Game
  include Diagram

  attr_accessor :words, :crossed_letters, :user_guess_array, :chosen_word_array, :user_fails

  def initialize
    @words = Words.new
  end

  def game_setup
    self.user_fails = 0  
    @crossed_letters = []
    self.chosen_word_array = words.dictionary.sample.downcase.chars
    self.user_guess_array = Array.new(chosen_word_array.length, '_')
  end

  def guess_tray
    user_guess_array.reduce do |string, char|
      string = '' if string.nil?
      string = string + ' ' + char
      string.strip!
      string
    end
  end

  def display
    puts(diagram[user_fails])
    puts(guess_tray)
    puts("Crossed out letters: #{crossed_letters.join(', ')}") unless crossed_letters.empty?
  end

  def guess_word(guess_array)
    if guess_array == chosen_word_array
      self.user_guess_array = chosen_word_array
    else
      puts("#{guess_array.join} wasn't correct!")
      self.user_fails += 1
    end
  end

  def guess_letter(guess_string)
    if chosen_word_array.include?(guess_string)
      chosen_word_array.each_with_index do |letter, i|
        user_guess_array[i] = letter if letter.eql?(guess_string)
      end
    else
      puts("#{guess_string} wasn't correct!")
      self.user_fails += 1
      crossed_letters.push(guess_string)
    end
  end

  def game_command(input)
    case 
    #binding.pry
    when crossed_letters.any? { |letter| input.include?(letter)}
      puts("\"#{input.join.upcase}\" includes crossed out letters!")
      user_turn
    when input.length >= chosen_word_array.length
      guess_word(input[0...chosen_word_array.length])
    when ('a'..'z').include?(input.first) && user_guess_array.any? { |letter| input.first == letter}
      puts("You've already confirmed \"#{input.first.upcase}\"!")
      user_turn
    when ('a'..'z').include?(input.first)
      guess_letter(input.first)
    else
      puts("Enter a letter.")
      user_turn
    end
  end

  def user_turn
    user_input = gets.chomp.downcase.chars
    game_command(user_input)
  end

  def game_over?
    user_guess_array.eql?(chosen_word_array)
  end

  def save_game
    
  end

  def begin_game
    until user_fails.eql?(6)
      display
      user_turn
      break if game_over?
    end
  end

  def game_end
    puts "The word was: #{chosen_word_array.join.capitalize}"
    user_guess_array == chosen_word_array ? puts('You win!') : puts('Better luck next time!')
    puts("Play again?\n\'Y\'es or \'N\'o.")
    gets.chomp.downcase.chr == 'y' ? play : puts('Game ended.')
  end

  def play
    game_setup
    begin_game
    game_end
  end
end

puts('Game loading...')
game = Game.new
puts('Game loaded')
game.play