class Oystercard
  attr_reader :balance

  BALANCE_UPPER_LIMIT = 90
  BALANCE_LOWER_LIMIT = 0
  BALANCE_BARRIER_LIMIT = 1
  JOURNEY_PRICE = 2
  INITIAL_JOURNEY_STATUS = false

  def initialize
    @balance = BALANCE_LOWER_LIMIT
    @in_journey = INITIAL_JOURNEY_STATUS
  end

  def top_up(ammount)
    fail "Sorry, the maximum balance is £#{BALANCE_UPPER_LIMIT}" if balance + ammount > BALANCE_UPPER_LIMIT
    @balance += ammount
  end


  def in_journey?
    @in_journey
  end

  def touch_in
    fail 'You cannot touch in again if you are in a journey' if in_journey? == true
    fail "You cannot touch in if your balance is less than #{BALANCE_BARRIER_LIMIT}" if balance < BALANCE_BARRIER_LIMIT
    @in_journey = !INITIAL_JOURNEY_STATUS
  end

  def touch_out
    fail 'You cannot touch out if you are not in a journey' if in_journey? == false
    @in_journey = INITIAL_JOURNEY_STATUS
    deduct(JOURNEY_PRICE)
  end

  private

  def deduct(ammount)
    @balance -= ammount
  end
end
