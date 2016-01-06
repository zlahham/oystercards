require "oystercard"

describe Oystercard do
  let(:max_balance) { Oystercard::BALANCE_LIMIT }
  let(:min_balance) { Oystercard::BALANCE_LOWER_LIMIT }
  let(:test_number) { 5 }
  let(:journey_status) { Oystercard::INITIAL_JOURNEY_STATUS }

  it 'that are NEW should have a balance of zero' do
    expect(subject.balance).to eq min_balance
  end

  # it { is_expected.to respond_to(:top_up, :deduct).with(1).argument }

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

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?, :touch_in, :touch_out) }

    it 'should be false to begin with' do
      expect(subject.in_journey?).to be journey_status
    end

    it 'when #touch_in changes the journey status to true' do
      subject.touch_in
      expect(subject.in_journey?).to be !journey_status
    end

    it 'when #touch_out changes the journey status to false' do
      subject.touch_in
      expect(subject.in_journey?).to be !journey_status
    end
  end


end
