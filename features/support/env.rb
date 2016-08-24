require "./app.rb"

require 'rspec/expectations'
require 'rack/test'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body

  def app
    Tritech::API
  end
end

Model.execute("TRUNCATE organizations, users, products;")

World{MyWorld.new}