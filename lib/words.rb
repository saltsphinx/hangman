# frozen_string_literal: true

class Words
  attr_accessor :dictionary
  def initialize
    @dictionary = File.readlines('words.txt', chomp: true)
  end
end