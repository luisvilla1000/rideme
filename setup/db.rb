# Require libraries
require 'sequel'
require 'sequel/extensions/seed'
require "yaml"

Sequel.database_timezone = :utc
Sequel.extension :seed
Sequel::Model.plugin :timestamps
Sequel::Model.plugin :json_serializer


config = YAML.load_file("config/database.yml")
DB = Sequel.connect(config["development"]["url"])
