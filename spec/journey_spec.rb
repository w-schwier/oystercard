require 'journey'

# subject(:journey) {described_class.new}

describe Journey do

  subject(:journey) {described_class.new("Tooting")}
  let(:station) {double :station}

  it 'sets entry station variable to station when touched in' do
    expect(journey.entry_station).to eq "Tooting"
  end

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  # it 'Finishes journey' do
  #   expect(journey.finish(station)).to eq station
  # end

end
