require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

RSpec.describe Turn do
  before(:all) do
    @card_1 = Card.new(:heart, 'Jack', 11)
    @card_2 = Card.new(:heart, '10', 10)
    @card_3 = Card.new(:heart, '9', 9)
    @card_4 = Card.new(:diamond, 'Jack', 11)
    @card_5 = Card.new(:heart, '8', 8)
    @card_6 = Card.new(:diamond, 'Queen', 12)
    @card_7 = Card.new(:heart, '3', 3)
    @card_8 = Card.new(:diamond, '2', 2)
    @card_9 = Card.new(:diamond, '8', 8)
  end

  it "exists" do
    deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
    deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
    player_1 = Player.new('Michael', deck_1)
    player_2 = Player.new('Megan', deck_2)
    turn = Turn.new(player_1, player_2)

    expect(turn).to be_an_instance_of(Turn)
  end

  it "has readable attributes" do
    deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
    deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
    player_1 = Player.new('Michael', deck_1)
    player_2 = Player.new('Megan', deck_2)
    turn = Turn.new(player_1, player_2)

    expect(turn.player_1).to eq(player_1)
    expect(turn.player_2).to eq(player_2)
    expect(turn.spoils_of_war).to eq([])
  end

  describe 'type method' do
    it 'returns :basic if top cards are different ranks' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)

      expect(turn.type).to eq(:basic)
    end

    it 'returns :war if top cards are the same rank' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)

      expect(turn.type).to eq(:war)
    end

    it 'returns :mutually_assured_destruction if top cards and index 2 are the same rank' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_9, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)

      expect(turn.type).to eq(:mutually_assured_destruction)
    end
  end

  describe 'winner method' do
    it 'turn.type = :basic' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)

      expect(turn.winner).to eq(player_1)
    end

    it 'turn.type = :war' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)

      expect(turn.winner).to eq(player_2)
    end

    it 'turn.type = :mutually_assured_destruction' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_9, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)

      expect(turn.winner).to eq('No Winner')
    end
  end

  describe 'pile_cards method' do
    it 'turn.type = :basic' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)
      turn.pile_cards

      expect(turn.spoils_of_war.length).to eq(2)
      expect(player_1.deck.cards.length).to eq(3)
      expect(player_1.deck.cards.length).to eq(3)
    end

    it 'turn.type = :war' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)
      turn.pile_cards

      expect(turn.spoils_of_war.length).to eq(6)
      expect(player_1.deck.cards.length).to eq(1)
      expect(player_1.deck.cards.length).to eq(1)
    end

    it 'turn.type = :mutually_assured_destruction' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_9, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)
      turn.pile_cards

      expect(turn.spoils_of_war.length).to eq(0)
      expect(player_1.deck.cards.length).to eq(1)
      expect(player_1.deck.cards.length).to eq(1)
    end
  end

  describe 'award_spoils method' do
    it 'turn.type = :basic' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)
      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(player_1.deck.cards.length).to eq(5)
      expect(player_2.deck.cards.length).to eq(3)
    end

    it 'turn.type = :war' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_6, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)
      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(player_1.deck.cards.length).to eq(1)
      expect(player_2.deck.cards.length).to eq(7)
    end

    it 'turn.type = :mutually_assured_destruction' do
      deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
      deck_2 = Deck.new([@card_4, @card_3, @card_9, @card_7])
      player_1 = Player.new('Michael', deck_1)
      player_2 = Player.new('Megan', deck_2)
      turn = Turn.new(player_1, player_2)
      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(player_1.deck.cards.length).to eq(1)
      expect(player_2.deck.cards.length).to eq(1)
    end
  end
end
