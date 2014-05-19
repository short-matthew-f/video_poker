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

  RANK_STRING = { 
    deuce: "2", three: "3", four: "4", five: "5",
    six: "6", seven: "7", eight: "8", nine: "9",
    ten: "10", jack: "J", queen: "Q", king: "K", ace: "A"
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
    to_strings.join("\n")
  end

  def to_strings
    suit_s = SUIT_SYMBOLS[suit].colorize(color)
    rank_ul = RANK_STRING[rank].ljust(2).colorize(color)
    rank_lr = RANK_STRING[rank].rjust(2).colorize(color)
    
    [
      "┌─────┐", 
      "│YY  X│", 
      "│     │", 
      "│     │", 
      "│X  ZZ│", 
      "└─────┘"
    ].map do |card_row|
      card_row
        .gsub("X", suit_s)
        .gsub("YY", rank_ul)
        .gsub("ZZ", rank_lr)
    end
  end

  def to_h
    {rank: rank, suit: suit}
  end
  
  def dup
    Card.new(rank, suit)
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