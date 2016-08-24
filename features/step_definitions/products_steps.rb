Given(/^I have the correct params and I send them to products$/) do
  header 'Accept', "application/json"
  header 'Content-Type', "application/json"
  basic_auth(@organization.id, @organization.private_key)
  visit "/api/users/#{@user.id}/products?name=Pizza&category=food", :post
end

Then(/^I should have a product object$/) do
  @product = Hashie::Mash.new(JSON.parse(last_response.body))
end

Then(/^That product object should have a name$/) do
  expect(@product.name).to eql(Products.last.name)
end

Then(/^That product object should have a category$/) do
  expect(@product.category).to eql(Products.last.category)
end

Given(/^I add (\d+) products$/) do |arg1|
  header 'Accept', "application/json"
  header 'Content-Type', "application/json"
  basic_auth(@organization.id, @organization.private_key)
  arg1.to_i.times do |i|
    visit "/api/users/#{@user.id}/products?name=Pizza&category=food", :post
  end
end

Given(/^I request those products$/) do
  visit "/api/users/#{@user.id}/products", :get
end

Then(/^I should get back a list of products$/) do
  @products = JSON.parse(last_response.body).collect { |product| Hashie::Mash.new(product) }

  expect(@products.length).to eql(2)
  expect(@products[0].id).to_not be_empty
end
