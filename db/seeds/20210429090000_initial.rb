Sequel.seed(:development, :test) do # Applies only to "development" and "test" environments
  def run
    Rider.create \
      name: 'Luis Villamil', 
      email: 'luisvilla1000@gmail.com', 
      card_token: 'tok_test_10967_e6e71777457aF8Af1541df04cc928466', 
      card_token_type: 'CARD', 
      payment_source_id: '11306'

    Driver.create \
      name: 'Carlos Rojas', 
      lat: 4.65, 
      lng: -74.54

  end
end