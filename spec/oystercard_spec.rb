require "oystercard"

describe Oystercard do
  let(:max_balance) { Oystercard::BALANCE_LIMIT }
  let(:min_balance) { Oystercard::BALANCE_LOWER_LIMIT }
  let(:test_number) { 5 }

  it 'that are NEW should have a balance of zero' do
    expect(subject.balance).to eq min_balance
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance with the appropriate ammount' do
      expect{ subject.top_up(test_number) }.to change{ subject.balance }.by(test_number)
    end

    it "has a maximum top_up limit of £#{Oystercard::BALANCE_LIMIT}" do
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error("Sorry, the maximum balance is £#{max_balance}")
    end
  end

  describe "#deduct" do
    before {  subject.top_up(test_number) }

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'subtracts the ammount from the balance' do
      expect{ subject.deduct(test_number) }.to change{ subject.balance }.by(-test_number)
    end

    it 'cannot deduct from balance when insufficient funds' do
      expect{ subject.deduct(test_number+1) }.to raise_error("Sorry, you have insufficient funds for this journey")
    end
  end

end
