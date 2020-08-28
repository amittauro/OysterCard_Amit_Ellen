class Card
  MAX_VALUE = 90
  BALANCE = 0
  FARE = 3
  MIN_AMOUNT = 2

  attr_reader :balance

  def initialize
    @balance = BALANCE
    @touched_in_at = nil
    @journeys = []
  end

  def max_value
    MAX_VALUE
  end

  def add(money)
    return 'You can only top up to £90 maximum' if too_much?(money)

    @balance = money
  end

  def touch_in(station)
    @touched_in_at = station
    station.name
  end

  def touch_out(station)
    deduct
    record_journey = { :start => @touched_in_at.name, :end => station.name }
    @journeys << record_journey
    @touched_in_at = nil
    station.name
  end

  def deduct
    @balance -= FARE
  end

  def min_amount
    @balance >= MIN_AMOUNT
  end

  def touched_in_at
    @touched_in_at.name
  end

  def journey_history
    @journeys.map do |journey|
      "#{journey[:start]} to #{journey[:end]}"
    end.join("\n")
  end

  private

  def too_much?(money)
    @balance + money > MAX_VALUE
  end
end
