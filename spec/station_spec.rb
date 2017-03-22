require 'station'

describe Station do
  subject(:station) {described_class.new("Tooting", 3)}


  it 'Checks name has been set correctly' do
    expect(station.name).to eq "Tooting"
  end

  it 'Checks zone has been set correctly' do
    expect(station.zone).to eq 3
  end
end
