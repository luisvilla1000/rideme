module Payments
  class Charge
    def initialize(ride_transaction)
      @ride_transaction = ride_transaction
      @ride = @ride_transaction.ride
      @rider = @ride.rider

      @args = {
          amount: @ride_transaction.amount,
          email: @rider.email,
          reference: "RIDE-@ride_transaction.id",
          payment_source_id: @rider.payment_source_id
      }
    end

    def process
      response = Wompi.new.charge(@args)
      response
    end
  end
end