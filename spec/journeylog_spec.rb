require 'journeylog'

describe JourneyLog do

subject(:log) {described_class.new}

  describe "#log" do
    it "is expected to have a log" do
      expect(log).to respond_to :log
    end
  end
end
