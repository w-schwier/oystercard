class Journey

  attr_reader :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def complete?
    false
  end


  private
  attr_writer :entry_station

end
