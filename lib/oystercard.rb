class Oystercard
  attr_reader :balance, :limit, :entry_station

  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station = nil
  end

  def top_up(amount)
    raise "Cannot top-up card: Exceeds limit of £#{self.limit}." if exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    fail "Can't touch in: Balance too low" if (self.balance < MINIMUM_BALANCE)
    self.entry_station = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    self.entry_station = nil
  end

  private
  attr_writer :balance, :entry_station

  def exceeds_limit?(amount)
    self.balance + amount > limit
  end

  def deduct(amount)
    self.balance -= amount
  end

  def in_journey?
    !!entry_station
  end
end
