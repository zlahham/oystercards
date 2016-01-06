class Oystercard
  attr_reader :balance

  BALANCE_LIMIT = 90
  BALANCE_LOWER_LIMIT = 0
  INITIAL_JOURNEY_STATUS = false


  def initialize
    @balance = BALANCE_LOWER_LIMIT
    @in_journey = INITIAL_JOURNEY_STATUS
  end

  def top_up(ammount)
    fail "Sorry, the maximum balance is £#{BALANCE_LIMIT}" if balance + ammount > BALANCE_LIMIT
    @balance += ammount
  end

  def deduct(ammount)
    fail "Sorry, you have insufficient funds for this journey" if balance - ammount < BALANCE_LOWER_LIMIT
    @balance -= ammount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = !INITIAL_JOURNEY_STATUS
  end

  def touch_out
    #code
  end
end
