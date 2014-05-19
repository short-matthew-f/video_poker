require './hand_comparable'
require './hand_describable'

class Hand
  include HandComparable
  include HandDescribable

  def self.draw_hand(deck)
    Hand.new(deck.draw(5))
  end

  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def to_a
    cards.map(&:to_h)
  end

  def fold(deck)
    deck.replace(cards) unless cards.empty?

    @cards = []
  end

  def hand_size
    cards.count
  end

  def empty?
    @cards.empty?
  end

  def to_s_sort!
    cards.sort_by! { |c| [Card.rank_value(c.rank), Card::SUITS.index(c.suit)] }
  end

  def discard(deck, discards)
    raise "Not all those cards are in your hand" if 
      (@cards & discards) != discards

    deck.replace(discards)

    @cards -= discards
  end

  def to_s
    strings = to_s_sort!.map(&:to_strings)

    (0...6).map do |i|
      (0...hand_size).map { |j| strings[j][i] }.join(' ')
    end.join("\n") + "\n" + (1..hand_size).map { |i| "  "+"#{i}".rjust(2)+"   " }.join(' ')
  end

  def draw(deck, number)
    @cards += deck.draw(number)
  end

  def swap_out(discards, deck)
    discards.each do |discard|
      @cards[@cards.index(discard)] = deck.top_card
      deck.replace([discard])
    end
  end
end