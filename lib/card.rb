class Card
  MAX_VALUE = 90
  BALANCE = 0
  FARE = 3
  MIN_AMOUNT = 2

  attr_reader :balance

  def initialize(journey_class: Journey)
    @balance = BALANCE
    @touched_in_at = nil
    @journeys = []
    @journey = journey_class
  end

  def max_value
    MAX_VALUE
  end

  def add(money)
    return 'You can only top up to £90 maximum' if too_much?(money)

    @balance = money
  end

  def touch_in(station)
    # @current_journey = @journey.new
    # @current_journey.touch_in(station) 
    
    if @touched_in_at != nil 
      deduct
      return "Not touched out, penalty fare deducted."
    end
    @touched_in_at = station
    station.name
  end

  def touch_out(station)
    return not_touched_in if @touched_in_at.nil?

    # @current_journey.end(station)
    # @balance -= journey.fare

    charge_fare(station)
    record_journey(station)
    reset_journey
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

  def not_touched_in
    deduct
    "Not touched in, penalty fare deducted"
  end

  def charge_fare(station)
    journey_zones = { :start => @touched_in_at.zone, :end => station.zone }
    calculate_fare = journey_zones[:start] / journey_zones[:end] * 3
    @balance -= calculate_fare
  end

  def record_journey(station)
    record_journey = { :start => @touched_in_at.name, :end => station.name }
    @journeys << record_journey
  end

  def reset_journey
    @touched_in_at = nil
  end
end
