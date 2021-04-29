module Rides
  class CalculateDistance
    def initialize(ride)
      @ride = ride
    end

    def process
      start_location = Geokit::LatLng.new(@ride.initial_lat, @ride.initial_lng)
      final_location = Geokit::LatLng.new(@ride.final_lat, @ride.final_lng)
      
      start_location.distance_to(final_location)
    end
  end
end