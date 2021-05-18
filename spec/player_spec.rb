require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'

RSpec.describe Player do
  before(:all) do
    @card = Card.new(:diamond, 'Queen', 12)
    @deck = Deck.new([@card])
    @player = Player.new('Michael', @deck)
  end

  it "exists" do
    expect(@player).to be_an_instance_of(Player)
  end

  it ".name returns the player's name" do
    expect(@player.name).to eq('Michael')
  end

  it ".deck returns the player's deck" do
    expect(@player.deck).to eq(@deck)
  end

  it ".has_lost? returns false if player has cards" do
    expect(@player.has_lost?).to be(false)
  end

  it ".has_lost? returns true if player is out of cards" do
    @player.deck.remove_card

    expect(@player.has_lost?).to be(true)
  end
end
