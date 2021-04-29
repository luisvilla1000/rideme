module Merchant
  class Acceptance
    def initialize
    end

    def process
      response = Wompi.new.merchant
      response['data']['presigned_acceptance']
    end
  end
end