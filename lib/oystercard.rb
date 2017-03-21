class Oystercard
  attr_reader :balance, :limit
  attr_writer :balance

  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @in_journey = false
  end

  def top_up(amount)
    raise "Cannot top-up card: Exceeds limit of £#{self.limit}." if exceeds_limit?(amount)
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Can't touch in: Balance too low" if (@balance < MINIMUM_BALANCE)
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceeds_limit?(amount)
    self.balance + amount > limit
  end
end
