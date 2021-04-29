module Payments
  class CreatePaymentSource
    def initialize(token_type, token, email, acceptance_token)
      @args = {
        token_type: token_type,
        token: token,
        customer_email: email,
        acceptance_token: acceptance_token
      }
    end

    def process
      response = Wompi.new.payment_sources(@args)
      response
    end
  end
end