class RideSerializer < BaseSerializer
  attributes :id, :rider_id, :driver_id, :started_at, :finished_at

  attribute :initial_coordinates do |object|
    [object.initial_lng, object.initial_lat]
  end

  attribute :final_coordinates do |object|
    [object.final_lng, object.final_lat]
  end

  attribute :amount, if: Proc.new { |record| record.ride_transactions.any? } do |ride|
    (ride.ride_transactions.last.amount / 100).round(2)
  end

  attribute :distance, if: Proc.new { |record| !record.finished_at.nil? } do |ride|
    Rides::CalculateDistance.new(ride).process
  end

  #belongs_to :rider
  #belongs_to :driver
end
