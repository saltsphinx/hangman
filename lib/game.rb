require_relative 'words.rb'
require_relative 'diagram.rb'

class Game
  include Diagram
  
  attr_accessor :words, :chosen_word

  def initialize
    @words = Words.new
  end

  def start_game
    @chosen_word = words.sample
  end
end