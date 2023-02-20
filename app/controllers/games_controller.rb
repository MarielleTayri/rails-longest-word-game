require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @contain = contain?(@word, @letters)
    @know_word = known_word?(@word)
  end

  def contain?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def known_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
