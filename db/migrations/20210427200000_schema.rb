Sequel.migration do
  change do
    create_table(:drivers) do
      primary_key :id
      String :name, :null => false
      Float :lat, :null => false
      Float :lng, :null => false
    end

    create_table(:riders) do
      primary_key :id
      String :name, :null => false
      String :email, :null => false
      String :card_token, :null => true
      String :card_token_type, :null => true
      String :acceptance_token, :null => true
      String :payment_source_id, :null => true
    end

    create_table(:rides) do
      primary_key :id
      foreign_key :rider_id, :riders
      foreign_key :driver_id, :drivers

      Float :initial_lat, :null => true
      Float :initial_lng, :null => true

      Float :final_lat, :null => true
      Float :final_lng, :null => true

      DateTime :started_at
      DateTime :finished_at
    end

    create_table(:ride_transactions) do
      primary_key :id
      foreign_key :ride_id, :rides
      Integer :amount
    end
  end
end