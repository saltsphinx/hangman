# frozen_string_literal: true

class Words
  def initialize
    @words = File.readlines('words.txt', chomp: true)
  end
end