require "oystercard"

describe Oystercard do
  it 'that are NEW should have a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'should accept top_ups' do
    expect(subject).to respond_to :top_up
  end

end
