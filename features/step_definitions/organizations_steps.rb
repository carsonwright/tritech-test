
Given /^I have the correct params and I send them to organizations$/ do
  header 'Accept', "application/json"
  header 'Content-Type', "application/json"
  visit "/api/organizations?name=Pizza Shop", :post
end

Then /^I should get an organization back$/ do
  @organization = Hashie::Mash.new(JSON.parse(last_response.body))
end
And /^That organization should have an id$/ do
  expect(@organization.id).to eql(Organizations.last.id) 
end
And /^That organization should have a public key$/ do
  expect(@organization.public_key).to  eql(Organizations.last.public_key) 
end
And /^That organization should have a private key$/ do
  expect(@organization.private_key).to  eql(Organizations.last.private_key)
end
