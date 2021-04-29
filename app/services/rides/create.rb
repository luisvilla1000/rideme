module Rides
  class Create
    def initialize(rider, initial_coordinates)
      @rider = rider
      @initial_coordinates = initial_coordinates
    end

    def process

      # If the client does not have a payment source, 
      # an attempt is made to create (a tokenized card must previously exist)
      if @rider.payment_source_id.nil?

        # To create a source of payment it is required to accept TOS. 
        # However this process must be interactive. 
        # For the ease of the project, it is assumed that it accepts them automatically.
        result = Merchant::Acceptance.new.process
        acceptance_token = result['acceptance_token']        

        payment_source = Payments::CreatePaymentSource.new(@rider.card_token_type, @rider.card_token, @rider.email, acceptance_token)
        result = payment_source.process

        @rider.update(acceptance_token: acceptance_token, payment_source_id: result['data']['id'])
      end

      ride = Ride.create(initial_lat: @initial_coordinates[1], initial_lng: @initial_coordinates[0], rider_id: @rider.id)
      
      ride
    end
  end
end