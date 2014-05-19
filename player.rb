class Player
  attr_accessor :pot, :hand

  def initialize(pot = 1000)
    @pot = pot
    @hand = Hand.new
  end

  def cards
    hand.cards
  end

  def fold(deck)
    hand.fold(deck)
  end

  def hand_size
    hand.hand_size
  end

  def new_hand(deck)
    fold(deck) unless hand.empty?

    hand.draw(deck, 5)
  end

  def discard(deck, cards)
    hand.discard(deck, cards)
  end

  def draw(deck, n)
    hand.draw(deck, n)
  end

  def place_bet(bet)
    @pot -= bet
  end

  def pay_bet(winnings)
    @pot += winnings
  end
end