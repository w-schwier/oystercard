require 'oystercard'
describe "Feature Test" do
  describe Oystercard do
    it "To add money to card, tests #top_up method." do
      card = Oystercard.new
      card.top_up(20)
      expect(card.balance).to eq 20
    end
  end
end
