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

    it "Remembers entry station" do
      card.top_up(top_up_amount)
      expect(card.touch_in(station)).to eq card.entry_station
    end

  end

  describe '#touch_out' do
    it 'Changes card to not in journey' do
      expect(card.touch_out(station)).to eq nil
    end

    it 'Charges card by minimum amount at touch out' do
      card.top_up(top_up_amount)
      # card.touch_in
      expect{card.touch_out(station)}.to change{card.balance}.by -Oystercard::MINIMUM_BALANCE
    end
  end

  describe 'Oystercard history' do
    it 'Checks new card has empty history' do
      expect(card.history).to eq []
    end

    it 'Checks the card history of the included journeys' do
      card.top_up(top_up_amount)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.history).to eq [journey]
    end
  end
end
