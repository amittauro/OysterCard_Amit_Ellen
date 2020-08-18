class Card
  MAX_VALUE = 90
  BALANCE = 0

  attr_reader :balance

  def initialize
    @balance = BALANCE
  end
  
  def max_value
    MAX_VALUE
  end

  def add(money)
    return 'You can only top up to £90 maximum' if too_much?(money)

    @balance = money
  end

  def touch_in(station)
    station.name
  end

  private

  def too_much?(money)
    @balance + money > MAX_VALUE
  end
end
