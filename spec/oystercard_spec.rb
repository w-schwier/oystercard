require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  top_up_amount = 20

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
      card.top_up(top_up_amount)
      expect(card.balance).to eq top_up_amount
    end
  end

  describe "Checks limit of card" do
    it "Checks card limited to £90" do
      expect(card.limit).to eq Oystercard::DEFAULT_LIMIT
    end
    it "Checks topping up over limit raises error" do
      message = "Cannot top-up card: Exceeds limit of £#{card.limit}."
      expect {card.top_up(Oystercard::DEFAULT_LIMIT + top_up_amount)}.to raise_error message
    end
  end

  describe "#deduct" do
=begin
    it "Card deducts amount" do
      card.top_up(top_up_amount)
      expect{card.deduct(top_up_amount)}.to change{card.balance}.by -top_up_amount
    end
=end
  end

  describe '#in_journey?' do
    it 'Checks if card is in journey' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'Changes card to in journey' do
      card.top_up(top_up_amount)
      expect(card.touch_in).to eq card.in_journey?
    end

    it "Can't touch in if balance < £1" do
      expect{card.touch_in}.to raise_error "Can't touch in: Balance too low"
    end

  end

  describe '#touch_out' do
    it 'Changes card to not in journey' do
      expect(card.touch_out).to eq card.in_journey?
    end

    it 'Charges card by minimum amount on touch out' do
      card.top_up(top_up_amount)
      # card.touch_in
      expect{card.touch_out}.to change{card.balance}.by -Oystercard::MINIMUM_BALANCE
    end
  end
end
