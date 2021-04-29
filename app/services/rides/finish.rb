module Rides
  class Finish
    def initialize(ride, final_coordinates)
      @ride = ride
      @final_coordinates = final_coordinates
    end

    def process
      @ride.update(final_lat: @final_coordinates[1], final_lng: @final_coordinates[0], finished_at: DateTime.now)

      amount = Rides::CalculateAmount.new(@ride).process

      result = RideTransaction.create(ride_id: @ride.id, amount: amount)
      ride_transaction = RideTransaction[result[:id]]

      transaction = Payments::Charge.new(ride_transaction)
      result = transaction.process
    end
  end
end