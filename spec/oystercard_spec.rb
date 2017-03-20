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
  it "Checks card limited to £90" do
    expect(card.limit).to eq Oystercard::DEFAULT_LIMIT
  end
  it "Checks card #exceeds_limit?" do
    expect(card.exceeds_limit?(100)).to eq true
  end
  it "Checks topping up over limit raises error" do
    message = "Cannot top-up card: Exceeds limit of £#{card.limit}."
    expect {card.top_up(100)}.to raise_error message
  end
end
