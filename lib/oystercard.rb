class Oystercard
  attr_reader :balance

  BALANCE_LIMIT = 90
  BALANCE_LOWER_LIMIT = 0


  def initialize
    @balance = BALANCE_LOWER_LIMIT
  end

  def top_up(ammount)
    fail "Sorry, the maximum balance is £#{BALANCE_LIMIT}" if balance + ammount > BALANCE_LIMIT
    @balance += ammount
  end

  def deduct(ammount)
    fail "Sorry, you have insufficient funds for this journey" if balance - ammount < BALANCE_LOWER_LIMIT
    @balance -= ammount
  end
end
