class Oystercard
  attr_reader :balance, :entry_station, :journeys, :latest_journey

  BALANCE_UPPER_LIMIT = 90
  BALANCE_LOWER_LIMIT = 0
  BALANCE_BARRIER_LIMIT = 1
  JOURNEY_PRICE = 2
  # STATION_NAMES = []

  def initialize
    @balance = BALANCE_LOWER_LIMIT
    @entry_station = nil
    @journeys = []
    @latest_journey = { entry: "", exit: "" }
  end

  def top_up(ammount)
    fail "Sorry, the maximum balance is £#{BALANCE_UPPER_LIMIT}" if balance + ammount > BALANCE_UPPER_LIMIT
    @balance += ammount
  end


  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    @latest_journey.replace({entry: "", exit: ""})
    fail 'You cannot touch in again if you are in a journey' if in_journey? == true
    fail "You cannot touch in if your balance is less than #{BALANCE_BARRIER_LIMIT}" if balance < BALANCE_BARRIER_LIMIT
    @entry_station = station
    @latest_journey[:entry] = station
  end

  def touch_out(station)
    fail 'You cannot touch out if you are not in a journey' if in_journey? == false
    deduct(JOURNEY_PRICE)
    @entry_station = nil
    @latest_journey[:exit] = station
    @journeys << [@latest_journey[:entry], @latest_journey[:exit]]
    puts "\nThank you for using your Oystercard, your previous journey was from #{@latest_journey[:entry]} to #{@latest_journey[:exit]} and your remaining balance is #{@balance}\n"
  end

  private

  def deduct(ammount)
    @balance -= ammount
  end
end
