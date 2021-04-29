class Ride < Sequel::Model
  many_to_one :driver
  many_to_one :rider

  one_to_many :ride_transactions
end