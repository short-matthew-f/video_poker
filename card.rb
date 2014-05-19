class Card
  SUITS = [
    :hearts, :diamonds, :clubs, :spades 
  ]

  SUIT_SYMBOLS = {
    hearts: "♥", diamonds: "♦", clubs: "♣", spades: "♠"
  }

  RANKS = [
    :deuce, :three, :four, :five, :six, :seven, :eight,
    :nine, :ten, :jack, :queen, :king, :ace
  ]

  CARD_STRINGS = {
    deuce:  ["┌─────┐", "│2   X│", "│     │", "│     │", "│X   2│", "└─────┘"],
    three:  ["┌─────┐", "│3   X│", "│     │", "│     │", "│X   3│", "└─────┘"],
    four:   ["┌─────┐", "│4   X│", "│     │", "│     │", "│X   4│", "└─────┘"],
    five:   ["┌─────┐", "│5   X│", "│     │", "│     │", "│X   5│", "└─────┘"],
    six:    ["┌─────┐", "│6   X│", "│     │", "│     │", "│X   6│", "└─────┘"],
    seven:  ["┌─────┐", "│7   X│", "│     │", "│     │", "│X   7│", "└─────┘"],
    eight:  ["┌─────┐", "│8   X│", "│     │", "│     │", "│X   8│", "└─────┘"],
    nine:   ["┌─────┐", "│9   X│", "│     │", "│     │", "│X   9│", "└─────┘"],
    ten:    ["┌─────┐", "│10  X│", "│     │", "│     │", "│X  10│", "└─────┘"],
    jack:   ["┌─────┐", "│J   X│", "│     │", "│     │", "│X   J│", "└─────┘"],
    queen:  ["┌─────┐", "│Q   X│", "│     │", "│     │", "│X   Q│", "└─────┘"],
    king:   ["┌─────┐", "│K   X│", "│     │", "│     │", "│X   K│", "└─────┘"],
    ace:    ["┌─────┐", "│A   X│", "│     │", "│     │", "│X   A│", "└─────┘"]
  }

  ACE_LOW_RANKS = RANKS.rotate(-1)

  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank, @suit = rank, suit
  end

  def color
    [:spades, :clubs].include?(suit) ? :black : :red
  end

  def to_s
    CARD_STRINGS[rank].map { |i| i.gsub("X", SUIT_SYMBOLS[suit].colorize(color)) }  
  end

  def to_h
    {rank: rank, suit: suit}
  end

  def self.rank_value(rank)
    RANKS.index(rank)
  end
  
  def rank_value
    RANKS.index(rank)
  end

  def self.suits
    SUITS
  end

  def self.ranks
    RANKS
  end
end