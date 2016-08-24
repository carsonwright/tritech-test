
Given /^I have the correct params and I send them to users$/ do
  header 'Accept', "application/json"
  header 'Content-Type', "application/json"
  basic_auth(@organization.id, @organization.private_key)
  visit "/api/users?first_name=John&last_name=Doe&email=johndoe@example.com", :post
end

Then /^I should have a user object$/ do
  @user = Hashie::Mash.new(JSON.parse(last_response.body))
end

And /^That user object should have a first name$/ do
  expect(@user.first_name).to eql(Users.last.first_name)
end

And /^That user object should have a last name$/ do
  expect(@user.last_name).to eql(Users.last.last_name)
end

And /^That user object should have an email$/ do
  expect(@user.email).to eql(Users.last.email)
end


And /^I add 2 users$/ do
  header 'Accept', "application/json"
  header 'Content-Type', "application/json"
  basic_auth(@organization.id, @organization.private_key)
  2.times do |i|
    visit "/api/users?first_name=John #{i}&last_name=Doe&email=johndoe#{i}@example.com", :post
  end
end

And /^I request my users$/ do
  visit "/api/users", :get
end

Then /^I should get back a list of users$/ do
  @users = JSON.parse(last_response.body).collect { |user| Hashie::Mash.new(user) }

  expect(@users.length).to eql(2)
  expect(@users[0].id).to_not be_empty
end
