require "oystercard"
require "station"

describe Station do

  describe "#station_name" do
    it { is_expected.to respond_to(:station_name) }

    xit "displays the name of the Station" do
      expect(subject.station_name). have_content object
    end
  end

  describe "#zone" do
    it { is_expected.to respond_to(:zone) }

    xit "displays the name of the Zone" do
      expect(subject.station_name). have_content object
    end
  end
end
