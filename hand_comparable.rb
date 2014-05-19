# the purpose of this module is to allow two equal valued hands to report
# back which one is better.

module HandComparable
  def group_sort
    grouped_cards = self.group

    grouped_cards.keys.sort do |rank_1, rank_2|
      [ grouped_cards[rank_2], Card.rank_value(rank_2) ] <=> 
      [ grouped_cards[rank_1], Card.rank_value(rank_1) ]
    end
  end

  def group
    Hash.new(0).tap do |h|
      @cards.each do |card|
        h[card.rank] += 1
      end
    end
  end

  def compare_to(other_hand) 
    self.group_sort.map {|r| Card.ranks.index(r)} <=>
      other_hand.group_sort.map {|r| Card.ranks.index(r)}
  end
end