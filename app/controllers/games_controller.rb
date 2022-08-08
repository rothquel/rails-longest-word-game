require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (
      ('a'..'z').to_a.shuffle[0..9]
    )
  end

  def check_word(response)
    url = "https://wagon-dictionary.herokuapp.com/#{response}"
    data_serialized = URI.open(url).read
    data = JSON.parse(data_serialized)
    if data["found"] == true
      return "Congratulations! This word is in the dictionary!\n\n
      You score #{response.length} points!"
    else
      return "Oh no - this word is not in the dictionary."
    end
    # user = JSON.parse(user_serialized)
    # puts "#{user["name"]} - #{user["bio"]}"
  end

  def score
    letters = params[:letters]
    word = params[:response]
    wordarray = word.split('')
    in_word = wordarray.all? do |letter|
      letters.include?(letter)
    end
    if in_word == true
      @response = check_word(word)
    else
      @response = "Your word can not be made out of #{letters}"
    end
  end
end
