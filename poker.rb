require './card.rb'
require './deck.rb'
require './hand.rb'
require './player.rb'
require 'colorize'

class Poker
  attr_reader :deck, :player

  def initialize
    @deck = Deck.new
    @player = Player.new
  end

  def play
    while true
      deal_cards
      display_header
      set_bet
      display_hand
      ask_for_discards
      replace_discarded_cards
      display_hand
      announce_winnings
      return_cards_to_deck
    end
  end

  def return_cards_to_deck
    player.fold(deck)
    deck.shuffle
  end

  def ask_for_discards
    begin
      print "Which cards do you wish to discard? (e.g. 1,3,4,5) > "
      hold = gets.chomp.split(',').map {|i| Integer(i) }
    rescue StandardError => e
      retry
    end

    player.discard(deck, hold.map { |i| player.cards[i-1] })
  end

  def replace_discarded_cards
    player.draw(deck, 5-player.hand_size)
  end

  def announce_winnings

  end

  def deal_cards
    player.new_hand(deck)
  end

  def set_bet
    begin
      print "Enter bet > "
      bet = Integer(gets.chomp)
      raise "Not enough in your bankroll to cover the bet." if bet > player.pot
    rescue StandardError => e
      puts e.message
      retry
    end

    player.place_bet(bet)
  end

  def display_header
    puts "Welcome to Draw Poker\n\nBankroll is: #{player.pot}"
  end

  def display_hand
    puts player.hand
  end

  def display_footer
    "You currently have a #{player.hand.value.to_s.gsub('_', ' ')}"
  end
  
  # def sort(hands)
  #   hands.sort { |x,y| x.beats?(y) }
  # end
end

if __FILE__ == $PROGRAM_NAME
  poker = Poker.new
  poker.play
end