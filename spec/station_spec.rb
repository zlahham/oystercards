require "oystercard"
require "station"

describe Station do

  let(:station) { described_class.new(:Victoria) }
  subject {described_class.new(:Victoria)}

  it { is_expected.to respond_to(:name, :zone) }

  it "displays the name of the Station" do
    expect(station.name).to eq :Victoria
  end

  it "displays the Zone number" do
    expect(station.zone).to eq 1
  end

end
