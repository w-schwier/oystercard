require 'journeylog'

describe JourneyLog do

subject(:log) {described_class.new}

  describe "#log" do
    it "is expected to have a log" do
      expect(card).to respond_to :balance
    end
  end  
end
