require 'station'

describe Station do
  subject(:station) {described_class.new("Tooting")}


  it 'Checks name has been set' do
    expect(station.name).to eq "Tooting"
  end
end
