require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:station) {double(:station)}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  top_up_amount = 20

  describe "#balance" do
    it "To have money on the card, checks balance" do
      expect(card).to respond_to :balance
    end
  end

  describe "#top_up" do
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

  describe '#touch_in' do
    it "Can't touch in if balance < £1" do
      expect{card.touch_in(station)}.to raise_error "Can't touch in: Balance too low"
    end

    it 'sets the current journey variable to a new instance of the journey class' do
      card.top_up 10
      expect(card.touch_in(station)).to eq card.current_journey
    end

    it "checks two tap ins in a row charges penalty fare" do
      card.top_up(20)
      card.touch_in(station)
      expect{card.touch_in(station)}.to change{card.balance}.by -Journey::PENALTY_FARE
    end

  end

  describe '#touch_out' do
    it 'Changes card to not in journey' do
      expect(card.touch_out(station)).to eq nil
    end

    it 'charges penalty fare if there was no touch_in' do
      expect{card.touch_out(station)}.to change{card.balance}.by -Journey::PENALTY_FARE
    end

    it 'Charges card by minimum amount at touch out' do
      card.top_up(top_up_amount)
      # card.touch_in
      expect{card.touch_out(station)}.to change{card.balance}.by -Oystercard::MINIMUM_BALANCE
    end
  end
end
