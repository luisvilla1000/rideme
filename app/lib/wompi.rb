class Wompi
    include HTTParty
    format :json

    debug_output $stdout
    base_uri 'https://sandbox.wompi.co/v1'
    read_timeout 10

    attr_reader :headers

    def initialize
        @pubkey = 'pub_test_u0eNRocWNEOhYJ9VqtxRKBFca75IalYc'
        @privkey = 'prv_test_FfSdfrhVJ1yXKa8763QIIezvRQTeLvYK'

        @options = { headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{@pubkey}"
            }
        }
    end

    def merchant
        uri = "/merchants/#{@pubkey}"
        do_request('get', uri)
    end
    
    def add_card
        uri = "/tokens/cards"

        body = {
            "number": "4242424242424242",
            "cvc": "789",
            "exp_month": "12",
            "exp_year": "29",
            "card_holder": "Pedro Pérez"
          }

        do_request('post', uri, body)
      end

    def payment_sources(args)
        uri = '/payment_sources'

        body = {
            type: args[:token_type],
            token: args[:token],
            customer_email: args[:customer_email],
            acceptance_token: args[:acceptance_token]
        }

        do_request('post', uri, body, :private)
    end

    def charge(args)
        uri = '/transactions'

        amount = args[:amount]
        email = args[:email]
        reference = args[:reference]
        payment_source_id = args[:payment_source_id]


        body = {
            "amount_in_cents": amount.to_i,
            "currency": "COP",
            "customer_email": email,
            "payment_method": {
              "installments": 1
            },
            "reference": reference,
            "payment_source_id": payment_source_id
        }

        do_request('post', uri, body, :private)
    end

    private

    def do_request(method, uri, body = {}, auth_key = :public)

        options_request = body.empty? ? {} : { body: body.to_json }
        options_request.merge!(@options)

        options_request[:headers]['Authorization'] = "Bearer #{@privkey}" if auth_key == :private

        begin
            response = self.class.send(method, uri, options_request)
            return response.parsed_response if response.code == 200
    
            { error: { errorCode: response.code, errorMessage: response.response.code_type.name } }
        rescue StandardError => e
            { error: { errorMessage: e.message } }
        end
    
    end
end