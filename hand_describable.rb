# the purpose of this module is to give names to each hand, such as 
# full house, three of a kind, etc.  Also to compare two hands by description.

module HandDescribable
  def ranks
    cards.map {|c| c.rank }
  end

  def suits
    cards.map {|c| c.suit }
  end

  def rank_count
    ranks.uniq.count
  end

  def suit_count
    suits.uniq.count
  end

  def flush?
    self.suit_count == 1
  end

  def rank_high_sort
    ranks.sort_by do |rank|
      Card.rank_value(rank)
    end
  end

  def rank_low_sort
    ranks.sort_by do |rank|
      Card::ACE_LOW_RANKS.index(rank)
    end
  end

  def rank_high_range
    Card.rank_value(rank_high_sort.last) - Card.rank_value(rank_high_sort.last) + 1
  end

  def rank_low_range
    Card.rank_value(rank_low_sort.last) - Card.rank_value(rank_low_sort.last) + 1
  end

  def straight?
    rank_count == 5 && [rank_high_range, rank_low_range].include?(5)
  end

  def four_of_a_kind?
    rank_count == 2 && group.values.include?(4)
  end

  def full_house?
    rank_count == 2 && group.values.include?(3)
  end

  def three_of_a_kind?
    rank_count == 3 && group.values.include?(3)
  end

  def two_pair?
    rank_count == 3 && group.values.include?(2)
  end

  def one_pair?
    rank_count == 4
  end

  VALUES = [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_a_kind,
    :straight_flush,
    :royal_flush
  ]

  def value
    if straight? && flush? && rank_high_sort.first == :ten
      :royal_flush
    elsif straight? && flush?
      :straight_flush
    elsif straight?
      :straight
    elsif flush?
      :flush
    elsif four_of_a_kind?
      :four_of_a_kind
    elsif full_house?
      :full_house
    elsif three_of_a_kind?
      :three_of_a_kind
    elsif two_pair?
      :two_pair
    elsif one_pair?
      :one_pair
    else
      :high_card
    end
  end

  def beats?(other_hand)
    # first_glance looks at things like :two_pair vs. :full_house
    first_glance = VALUES.index(self.value) <=> VALUES.index(other_hand.value)
    case first_glance
    when -1
      return -1
    when 1
      return 1
    when 0
      # second_glance only happens if the hands have the same value
      return self.compare_to(other_hand)
    end
  end
end




