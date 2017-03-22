require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :limit, :entry_station, :history, :current_journey

  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station = nil
    @history = []
    @current_journey = Journey.new
  end

  def top_up(amount)
    raise "Cannot top-up card: Exceeds limit of £#{self.limit}." if exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    fail "Can't touch in: Balance too low" if (self.balance < MINIMUM_BALANCE)
    deduct(current_journey.fare) if !(current_journey.entry_station.nil?)
    @current_journey = Journey.new(entry_station: station)
  end

  def touch_out(station)
    self.history.push({entry_station: entry_station, exit_station: station})
    deduct(MINIMUM_BALANCE)
    #@current_journey.finish(station)
    self.entry_station = nil
  end

  private
  attr_writer :balance, :entry_station, :history

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
