require "amatista"
require "pg"
require "json"
require "./src/view_models/**"
require "./src/models/*"
require "./src/helpers/*"
require "./src/controllers/*"
require "option_parser"
require "redis"

class Main < Amatista::Base
  configure do |conf|
    conf[:secret_key] = "secret"
    conf[:database_driver] = "postgres"
    conf[:database_connection] = ENV["DATABASE_URL"]
    conf[:logs] = true
  end
end
