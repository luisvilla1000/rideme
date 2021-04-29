module Rides
  class CalculateAmount
    def initialize(ride)
      @ride = ride
    end

    def process

      kilometers = Rides::CalculateDistance.new(@ride).process
      minutes_elapsed = ((Time.parse(@ride.finished_at.to_s) - Time.parse(@ride.started_at.to_s)) / 60).ceil

      amount = 3500
      amount += 1000 * kilometers
      amount += 200 * minutes_elapsed

      # Fix amount cents
      amount = (amount.round(2) * 100).to_i

      amount
    end
  end
end