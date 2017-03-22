class Journey

  attr_reader :entry_station

  PENALTY_FARE = 6

  def initialize(entry_station: entry_station)
    @entry_station = entry_station
  end

  def complete?
    false
  end

  def fare
    PENALTY_FARE
  end

  def finish(station)
    self
  end


  private
  attr_writer :entry_station

end
