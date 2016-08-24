Feature: Products
  Scenario: Add product to user
    Given I have the correct params and I send them to organizations
      And I should get an organization back
      And I have the correct params and I send them to users
      And I should have a user object
      And I have the correct params and I send them to products
     Then I should have a product object
      And That product object should have a name
      And That product object should have a category
  Scenario: List user's products
    Given I have the correct params and I send them to organizations
      And I should get an organization back
      And I have the correct params and I send them to users
      And I should have a user object
      And I add 2 products
      And I request those products
     Then I should get back a list of products