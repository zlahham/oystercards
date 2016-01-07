class Oystercard
  attr_reader :balance, :entry_station, :journeys, :latest_journey

  BALANCE_UPPER_LIMIT, BALANCE_LOWER_LIMIT, BALANCE_BARRIER_LIMIT, JOURNEY_PRICE = 90, 0, 1, 2

  def initialize
    @balance, @entry_station, @journeys, @latest_journey = BALANCE_LOWER_LIMIT, nil, [], { entry: "", exit: "" }
  end

  def top_up(ammount)
    fail "Sorry, the maximum balance is £#{BALANCE_UPPER_LIMIT}" if balance + ammount > BALANCE_UPPER_LIMIT
    @balance += ammount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    failures_touch_in
    touch_in_allocations(station)
  end

  def touch_out(station)
    fail 'You cannot touch out if you are not in a journey' if in_journey? == false
    deduct(JOURNEY_PRICE)
    touch_out_allocations(station)
    puts "\nThank you for using your Oystercard, your previous journey was from #{@latest_journey[:entry]} to #{@latest_journey[:exit]} and your remaining balance is #{@balance}\n"
  end

  private

  def deduct(ammount)
    @balance -= ammount
  end

  def failures_touch_in
    fail 'You cannot touch in again if you are in a journey' if in_journey? == true
    fail "You cannot touch in if your balance is less than #{BALANCE_BARRIER_LIMIT}" if balance < BALANCE_BARRIER_LIMIT
  end

  def touch_out_allocations(station)
    @entry_station = nil
    @latest_journey[:exit] = station
    @journeys << [@latest_journey[:entry], @latest_journey[:exit]]
  end

  def touch_in_allocations(station)
    @latest_journey.replace({entry: "", exit: ""})
    @entry_station = station
    @latest_journey[:entry] = station
  end
end
