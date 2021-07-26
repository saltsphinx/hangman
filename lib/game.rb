require_relative 'words.rb'
require_relative 'diagram.rb'

class Game
  include Diagram

  attr_accessor :words, :user_guess_array, :chosen_word_array, :guess_display, :user_fails

  def initialize
    @words = Words.new
  end

  def game_setup
    self.user_fails = 0
    self.chosen_word_array = words.dictionary.sample.split('')
    self.user_guess_array = Array.new(chosen_word_array.length, '_')
    self.guess_display = '%d ' * chosen_word_array.length
    guess_display.strip!
  end

  def play
    game_setup
    display
  end

  def display
    puts diagram[user_fails]
    puts guess_display
  end
end

puts 'Game loading...'
game = Game.new
puts 'Game loaded'
game.play