require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  describe "#balance" do
    it "To have money on the card, checks balance" do
      expect(card).to respond_to :balance
    end
  end

  describe "#top_up" do
    it "Checks card responds to #top_up" do
      expect(card).to respond_to(:top_up).with(1).argument
    end
    it "Adds money to the card" do
      card.top_up(20)
      expect(card.balance).to eq 20
    end
  end

  describe "Checks limit of card" do
    it "Checks card limited to £90" do
      expect(card.limit).to eq Oystercard::DEFAULT_LIMIT
    end
    it "Checks topping up over limit raises error" do
      message = "Cannot top-up card: Exceeds limit of £#{card.limit}."
      expect {card.top_up(100)}.to raise_error message
    end
  end

  describe "#deduct" do
    it "Card deducts amount" do
      card.top_up(40)
      expect{card.deduct(20)}.to change{card.balance}.by -20
    end
  end
end
