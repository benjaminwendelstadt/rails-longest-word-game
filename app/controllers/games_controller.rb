require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ['a'..'z'][0].to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    splitword = params[:word].split(//)
    if !repetition(splitword)
      @result = "Sorry, but #{params[:word].upcase} can't be built out of the grid"
    else
      @result = validate_word(params[:word])
    end
  end

  private

  def repetition(splitword)
    splitword.all? do |letter|
      splitword.count(letter) <= params[:letters].count(letter)
    end
  end

  def validate_word(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    data = open(url).read
    if JSON.parse(data)['found'] == true
      return "CONGRATULATIONS! #{params[:word].upcase} is a valid English word"
    else
      return "Sorry, but #{params[:word].upcase} is not a valid English word"
    end
  end
end
