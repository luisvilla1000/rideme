class RideTransaction < Sequel::Model
  many_to_one :ride
end