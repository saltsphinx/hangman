require_relative 'words.rb'
require_relative 'diagram.rb'

class Game
  include Diagram

  attr_accessor :words, :user_guess_array, :chosen_word_array, :user_fails

  def initialize
    @words = Words.new
  end

  def game_setup
    self.user_fails = 0
    self.chosen_word_array = words.dictionary.sample.split('')
    self.user_guess_array = Array.new(chosen_word_array.length, '_')
  end

  def guess_tray
    user_guess_array.reduce('') do |string, char|
      string = string + ' ' + char
      string.strip!
      string
    end
  end

  def play
    game_setup
    display
  end

  def display
    current_guess = guess_tray % user_guess_array
    puts diagram[user_fails]
    puts guess_tray
  end
end

puts 'Game loading...'
game = Game.new
puts 'Game loaded'
game.play