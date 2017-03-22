require 'oystercard'

# subject(:journey) {described_class.new}

describe Journey do

  it 'sets entry station variable to station when touched in' do
    card = Oystercard.new
    station = Station.new("Tooting", 3)
    card.top_up 10
    card.touch_in(station)
    expect(subject.entry_station).to eq station

  end

end
