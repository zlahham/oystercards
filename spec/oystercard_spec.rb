require "oystercard"

describe Oystercard do
  it 'that are NEW should have a balance of zero' do
    oyster = Oystercard.new
    expect(oyster.balance).to eq 0
  end

end
