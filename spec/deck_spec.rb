require 'rspec'
require './lib/card'
require './lib/deck'

RSpec.describe Deck do
  before(:all) do
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_2 = Card.new(:spade, '3', 3)
    @card_3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @deck_2 = Deck.new([@card_1, @card_2, @card_3])
  end

  it "exists" do
    expect(@deck).to be_an_instance_of(Deck)
  end

  it ".cards returns cards in a deck" do
    expect(@deck.cards).to eq([@card_1, @card_2, @card_3])
  end

  it ".rank_of_card_at returns value of card at given index" do
    expect(@deck.rank_of_card_at(0)).to eq(12)
    expect(@deck.rank_of_card_at(2)).to eq(14)
  end

  it ".high_ranking_cards returns array of high rank cards" do
    expect(@deck.high_ranking_cards).to eq([@card_1, @card_3])
  end

  it ".percent_high_ranking returns percentage of high rank cards" do
    expect(@deck.percent_high_ranking).to eq(66.67)
  end

  it ".remove_card removes the top card of the deck" do
    @deck_2.remove_card

    expect(@deck_2.cards).to eq([@card_2, @card_3])
  end

  it ".add_card adds a card to the bottom of the deck" do
    new_card = Card.new(:club, '5', 5)
    @deck_2.add_card(new_card)

    expect(@deck_2.cards[-1]).to eq(new_card)
  end
end
