class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    cards[index].rank
  end

  def high_ranking_cards
    cards.filter_map{ |card| card if card.rank >= 11 }
  end

  def percent_high_ranking
    high_rank_count = cards.group_by { |card| card.rank >= 11 }[true].length.to_f
    ((high_rank_count / cards.length) * 100).round(2)
  end

  def remove_card
    cards.shift
  end

  def add_card(card)
    cards.push(card)
  end
end