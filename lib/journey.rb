class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station: entry_station)
    @entry_station = entry_station
  end

  def complete?
    (self.entry_station.nil? || self.exit_station.nil?) ? false : true
  end

  def fare
    complete? ? 1 : PENALTY_FARE
  end

  def finish(station)
    self.exit_station = station
    self
  end


  private
  attr_writer :entry_station, :exit_station

end
