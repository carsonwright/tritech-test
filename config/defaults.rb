ENV["DB_NAME"] ||= "tritech_development"
if ENV["RACK_ENV"] == "testing"
  ENV["DB_NAME"] ||= "tritech_testing"
end

