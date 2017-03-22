require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :limit, :entry_station, :history, :current_journey

  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @history = JourneyLog.new
    @current_journey = Journey.new
  end

  def top_up(amount)
    raise "Cannot top-up card: Exceeds limit of £#{self.limit}." if exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    fail "Can't touch in: Balance too low" if (self.balance < MINIMUM_BALANCE)
    deduct(current_journey.fare) if !(current_journey.entry_station.nil?)
    self.current_journey = Journey.new(entry_station: station)
  end

  def touch_out(station)
    current_journey.finish(station)
    deduct(current_journey.fare)
    history.log.push(current_journey)
    self.current_journey = Journey.new
  end

  private
  attr_writer :balance, :entry_station, :history, :current_journey

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
