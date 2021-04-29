require "sinatra"
#require 'sinatra/contrib'
#require "sinatra/namespace"
require 'httparty'
require 'jsonapi/serializer'
require 'geokit'
require "sinatra/reloader" if @Env == "development"
require 'pry-remote' if @Env == "development"
require "envyable" if @Env == "development"
