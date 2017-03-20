class Oystercard
  attr_reader :balance, :limit
  attr_writer :balance

  DEFAULT_LIMIT = 90

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
  end

  def top_up(amount)
    raise "Cannot top-up card: Exceeds limit of £#{self.limit}." if exceeds_limit?(amount)
    self.balance += amount
  end

  def exceeds_limit?(amount)
    self.balance + amount > limit
  end
end
