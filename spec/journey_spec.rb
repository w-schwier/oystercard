require 'oystercard'

# subject(:journey) {described_class.new}

describe Journey do
  describe 'Oystercard history' do
    it 'Checks new card has empty history' do
      expect(subject.history).to eq []
    end

    # it 'Checks the history of the cards journeys' do
    #   card.top_up(top_up_amount)
    #   card.touch_in(entry_station)
    #   card.touch_out(exit_station)
    #   expect(card.history).to eq [journey]
    # end
  end

end
