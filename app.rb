require 'grape'
require 'pg'

if ENV["RACK_ENV"].to_s.downcase != 'production'
  require 'pry'
end

def require_path(dir)
  Dir[dir].each {|file| require file }
end

require_path("./config/*.rb")
require_path("./models/*.rb")
require_path("./api/*.rb")
