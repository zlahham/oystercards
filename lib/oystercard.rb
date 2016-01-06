class Oystercard
  attr_reader :balance

  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(ammount)
    fail "Sorry, the maximum balance is £#{BALANCE_LIMIT}" if balance + ammount > BALANCE_LIMIT
    @balance += ammount
  end

  def deduct(ammount)
  end
end
