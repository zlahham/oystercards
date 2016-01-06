require "oystercard"

describe Oystercard do
  let(:max_balance) { Oystercard::BALANCE_LIMIT }

  it 'that are NEW should have a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance with the appropriate ammount' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by(5)
    end

    it "has a maximum top_up limit of £#{Oystercard::BALANCE_LIMIT}" do
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error("Sorry, the maximum balance is £#{max_balance}")
    end
  end

end
