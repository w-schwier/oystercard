require 'journey'

# journey(:journey) {described_class.new}

describe Journey do

  let(:station) {double :station, zone: 1}
  subject(:journey) {described_class.new(entry_station: station)}

  it "knows if a journey is not complete" do
    expect(journey).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'Finishes journey' do
    expect(journey.finish(station)).to eq journey
  end

  context 'given an entry station' do

    it 'sets entry station variable to station when touched in' do
      expect(journey.entry_station).to eq station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    context 'Given an exit station' do
      let(:other_station) {double :other_station}
      before do
        journey.finish(other_station)
      end

      it "calculates a fare" do
        expect(journey.fare).to eq 1
      end

    end
  end
end
