require './app'

set :protection, :except => :json_csrf
run ApplicationController