class Deck
  def self.all_cards
    [].tap do |deck|
      Card.ranks.each do |rank|
        Card.suits.each do |suit|
          deck << Card.new(rank, suit)
        end
      end
    end
  end

  attr_reader :cards

  def initialize(cards = Deck.all_cards, shuff = true)
    @cards = cards

    shuffle if shuff
  end

  def top_card
    @cards.shift
  end

  def count
    @cards.count
  end
  
  def draw(num)
    raise "Not enough cards." if count < num

    @cards.shift(num)
  end

  def replace(discards)
    @cards += discards
  end

  def shuffle
    @cards.shuffle!

    nil
  end 
end