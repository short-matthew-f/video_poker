require './card.rb'
require './deck.rb'
require './hand.rb'
require './player.rb'
require 'colorize'

class Poker
  PAYOUTS = {
    high_card: 0,
    one_pair: 1,
    two_pair: 1,
    three_of_a_kind: 3,
    straight: 5,
    flush: 8,
    full_house: 10,
    four_of_a_kind: 25,
    straight_flush: 50,
    royal_flush: 250
  }

  attr_reader :deck, :player, :bet

  def initialize
    @deck = Deck.new
    @player = Player.new
  end

  def play
    puts "Welcome to Draw Poker\n\n"
    while player.pot > 0
      system('clear')
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
    hand_type = player.hand.value
    winnings = bet * PAYOUTS[hand_type]
    puts "Your hand was a #{hand_type.to_s.gsub('_', ' ')}."
    puts "You win #{winnings}, hit enter to continue."
    gets

    player.pay_bet(winnings)
  end

  def deal_cards
    player.new_hand(deck)
  end

  def set_bet
    begin
      print "Enter bet > "
      @bet = Integer(gets.chomp)
      raise "Not enough in your bankroll to cover the bet." if bet > player.pot
    rescue StandardError => e
      puts e.message
      retry
    end

    player.place_bet(@bet)
  end

  def display_header
    puts "Bankroll is: #{player.pot}"
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