require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  it "To have money on the card, checks balance" do
    expect(card).to respond_to :balance
  end

  it "Checks card responds to #top_up" do
    expect(card).to respond_to(:top_up).with(1).argument
  end
  it "Adds money to the card" do
    card.top_up(20)
    expect(card.balance).to eq 20
  end 
end
