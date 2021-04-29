module Rides
  class AsignDriver
    def initialize(ride)
      @ride = ride
    end

    def process
      # TODO An asignation strategy must be established (distance, availability ...)
      driver = Driver.last

      @ride.update(driver_id: driver.id, started_at: DateTime.now)
    end
  end
end