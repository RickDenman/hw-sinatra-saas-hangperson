class HangpersonGame
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if (letter == '') || !(letter=~ /[[:alpha:]]/)
      raise ArgumentError
    end
    lett = letter.downcase
    if (guesses.include? lett) || (wrong_guesses.include? lett)
      return false
    end
    if !(word.include? lett)
      @wrong_guesses += lett
      return true
    end
    @guesses += lett
    return true
  end
  
  def word_with_guesses()
    wrd = @word.downcase
    displa = ""
    wrd.each_char do |lett|
      if (@guesses.include? lett) 
        displa += lett
      else
        displa += '-'
      end
    end
    return displa
  end
  
  def check_win_or_lose
    if @guesses.size + @wrong_guesses.size == 7 
      return :lose
    else
      displa = word_with_guesses()
      if displa.include? '-'
        return :play
      else
        return :win
      end
    end
  end
end
