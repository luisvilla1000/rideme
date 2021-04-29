class ApplicationController < Sinatra::Base
    configure :development do
        register Sinatra::Reloader
    end

    before do
      content_type :json
    end

    get '/status' do
      'OK'
    end

    # Create a payments method
    post '/api/v1/payments/method' do
      options = JSON.parse(request.body.read)
      rider_id = options['rider_id'].to_i
      acceptance_token = options['acceptance_token']

      rider = Rider[rider_id]
      status 404 if rider.nil?

      payment_source = Payments::CreatePaymentSource.new(rider.card_token_type, rider.card_token, rider.email, acceptance_token)
      result = payment_source.process      
    end

    # Retrive a ride
    get '/api/v1/rides/:id' do
      ride = retrive_ride
      RideSerializer.new(ride).serializable_hash.to_json
    end

    # Create a ride
    post '/api/v1/rides' do
      options = JSON.parse(request.body.read)
      rider_id = options['rider_id'].to_i
      initial_coordinates = [options['lng'], options['lat']]

      rider = Rider[rider_id]
      status 404 if rider.nil?

      ride = Rides::Create.new(rider, initial_coordinates).process
      ride = Rides::AsignDriver.new(ride).process

      RideSerializer.new(ride).serializable_hash.to_json
    end

    # Finish a ride
    put '/api/v1/rides/:id' do
      ride = retrive_ride

      options = JSON.parse(request.body.read)
      final_coordinates = [options['lng'], options['lat']]

      result = Rides::Finish.new(ride, final_coordinates).process
      RideSerializer.new(ride).serializable_hash.to_json
    end

    private

    def retrive_ride
      ride = Ride[params[:id]]
      status 404 if ride.nil?

      ride
    end
end