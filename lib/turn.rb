class Turn
  attr_accessor :spoils_of_war
  attr_reader :player_1, :player_2
  
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @spoils_of_war = []
  end

  def type
    if @player_1.deck.rank_of_card_at(0) != @player_2.deck.rank_of_card_at(0)
      :basic
    elsif @player_1.deck.rank_of_card_at(2) == @player_2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    else
      :war
    end
  end

  def winner
    if type == :basic
      @player_1.deck.rank_of_card_at(0) > @player_2.deck.rank_of_card_at(0) ? @player_1 : @player_2
    elsif type == :war
      @player_1.deck.rank_of_card_at(2) > @player_2.deck.rank_of_card_at(2) ? @player_1 : @player_2
    else
      'No Winner'
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player_1.deck.remove_card
      @spoils_of_war << @player_2.deck.remove_card
    elsif type == :war
      3.times { @spoils_of_war << @player_1.deck.remove_card }
      3.times { @spoils_of_war << @player_2.deck.remove_card }
    else
      3.times { @player_1.deck.remove_card }
      3.times { @player_2.deck.remove_card }
    end
  end

  def award_spoils(winner)
    @spoils_of_war.each do |card|
      winner.deck.add_card(card)
    end
    @spoils_of_war = []
  end
end