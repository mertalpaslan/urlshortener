require 'bundler/setup'
Bundler.require(:default)
require_relative 'app/controllers/application_controller'
require_relative 'app/lib/pair'
require_relative 'app/lib/url'

run ApplicationController