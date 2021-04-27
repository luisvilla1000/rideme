# Load Config
App = JSON.parse(File.read("./config/config.json"), symbolize_names: true)

# Enable cross origin
enable :cross_origin
set :allow_origin, :any
set :allow_methods, [:get, :post, :put, :delete, :options]