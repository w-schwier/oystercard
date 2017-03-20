class Oystercard
  attr_reader :balance
  attr_writer :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    self.balance += amount
  end
end
