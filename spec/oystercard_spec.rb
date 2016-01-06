require "oystercard"

describe Oystercard do
  let(:max_card_balance)     { Oystercard::BALANCE_UPPER_LIMIT }
  let(:min_card_balance)     { Oystercard::BALANCE_LOWER_LIMIT }
  let(:barrier_balance) { Oystercard::BALANCE_BARRIER_LIMIT }
  let(:journey_status)  { Oystercard::INITIAL_JOURNEY_STATUS }
  let(:journey_price)   { Oystercard::JOURNEY_PRICE }
  let(:test_numbers)    { [5, 0.5] }

  it 'that are NEW should have a balance of zero' do
    expect(subject.balance).to eq min_card_balance
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance with the appropriate ammount' do
      expect{ subject.top_up(test_numbers[0]) }.to change{ subject.balance }.by(test_numbers[0])
    end

    it "has a maximum top_up limit of £#{Oystercard::BALANCE_UPPER_LIMIT}" do
      subject.top_up(max_card_balance)
      expect{ subject.top_up(1) }.to raise_error("Sorry, the maximum balance is £#{max_card_balance}")
    end
  end

  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?, :touch_in, :touch_out) }

    it 'should be false to begin with' do
      expect(subject).not_to be_in_journey
    end

    context 'when #touch_in or #touch_out' do

      describe "#touch_in" do
        it 'should be true when #touch_in' do
          subject.top_up(max_card_balance)
          subject.touch_in
          expect(subject).to be_in_journey
        end

        it 'raises error if #touch_in is with a previous #touch_in' do
          subject.top_up(max_card_balance)
          subject.touch_in
          expect { subject.touch_in }.to raise_error("You cannot touch in again if you are in a journey")
        end

        it 'raises an error if balance is less than minimum barrier balance' do
          subject.top_up(test_numbers[1])
          expect { subject.touch_in }.to raise_error("You cannot touch in if your balance is less than #{barrier_balance}")
        end
      end

      describe "#touch_out" do
        before { subject.top_up(max_card_balance) }

        it 'should be false when #touch_out' do
          subject.touch_in
          subject.touch_out
          expect(subject).not_to be_in_journey
        end

        it 'raises error if #touch_out is without previous #touch_in' do
          expect { subject.touch_out }.to raise_error("You cannot touch out if you are not in a journey")
        end

        it 'changes the balance according to the journey cost' do
          subject.touch_in
          expect { subject.touch_out }.to change{ subject.balance }.by(-journey_price)
        end
      end
    end
  end
end
